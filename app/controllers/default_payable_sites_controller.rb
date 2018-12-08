# -*- coding: utf-8 -*-
class DefaultPayableSitesController < BaseController
  helper_method :localize_attr, :localize_option, :site_date_to_s

  permit_attributes(
    :company_id, :contract_credit_category, :site_designation_method,
    :month, :day, :after_day, :holiday_transfer_method
  )

  def index
    selected_category = params[:selected_contract_credit_category]
    @instances = search_with_category(selected_category || model.contract_credit_category.all)
    if request.referer.match(/\/traders\/site\z/)
      @instances = @instances.where(trader_id: session[:editing_site_trader_id], setting_type: 1)
    else
      @instances = @instances.where(setting_type: 0)
    end

    respond_to do |format|
      if selected_category
        format.js { render 'index', locals: {sites: @instances} }
      else
        format.html { render 'edit', layout: false, locals: {sites: @instances} }
      end
    end
  end

  def update
    if request.referer.match /\/traders\/site\z/
      create_or_update_trader_site
    else
      update_default_site
    end
  end

  def make_trader_site_modal
    trader = Trader.find(params[:trader_id])
    session[:editing_site_trader_id] = params[:trader_id]
    sites = DefaultPayableSite.search(trader_id_eq: params[:trader_id], setting_type: 1).result
    respond_to do |format|
      if request.xhr?
        format.html { render 'edit', layout: false, locals: {sites: sites, trader: trader} }
      end
    end
  end

  private
  def loat_objects
    @intances = model.search(company_id_eq: @my_company.id).result
  end

  def update_default_site
    site_params = params[:default_payable_site]
    update_category = site_params[:contract_credit_category]

    if update_category == model.contract_credit_category.all
      all_contract_credit_category.each do |category|
        update_site_date(category, site_params)
      end
    else
      update_site_date(update_category, site_params)
    end

    @instances = search_with_category(update_category).where(setting_type: 0)

    respond_to do |format|
      if request.xhr?
        format.js { render 'update', locals: {sites: @instances} }
      end
    end
  end

  def create_or_update_trader_site
    site_params = params[:default_payable_site]
    trader = Trader.find(site_params[:trader_id])
    category = site_params[:contract_credit_category]
    designation_method = site_params[:site_designation_method]
    if designation_method == model.site_designation_method.month_day
      month = site_params[:month]
      day = site_params[:day]
      after_day = 0
    else
      month = 0
      day = 0
      after_day = site_params[:after_day]
    end

    if category == DefaultPayableSite.contract_credit_category.all
      categories = all_contract_credit_category
    else
      categories = [category]
    end

    categories.each do |category|
      site = DefaultPayableSite.search(
        company_id_eq: @my_company.id,
        trader_id_eq: trader.id,
        contract_credit_category_eq: category,
        setting_type_eq: 1
      ).result.first

      if site.present?
        site.update_attributes(
          site_designation_method: designation_method,
          month: month,
          day: day,
          after_day: after_day
        )
      else
        DefaultPayableSite.create(
          company_id: @my_company.id,
          trader_id: trader.id,
          contract_credit_category: category,
          site_designation_method: designation_method,
          holiday_transfer_method: model.holiday_transfer_method.following_business_day, #一次開発以降で変更
          month: month,
          day: day,
          after_day: after_day,
          setting_type: 1
        )
      end
    end

    @instances = search_with_category(category).search(trader_id_eq: trader.id, setting_type_eq: 1).result

    respond_to do |format|
      if request.xhr?
        format.js { render 'update', locals: {sites: @instances} }
      end
    end
  end

  def all_contract_credit_category
    all_categories = model.contract_credit_category.options.map { |c| c.second }
    all_categories -= [model.contract_credit_category.all.value]
    return all_categories
  end

  def search_with_category(category)
    if category == model.contract_credit_category.all
      model.of_ours(@my_company)
    else
      model.search(company_id_eq: @my_company.id, contract_credit_category_eq: category).result
    end
  end

  def update_site_date(category, site_params)
    designation_method = site_params[:site_designation_method]
    site = search_with_category(category).first.presence
    following_business_day = model.holiday_transfer_method.following_business_day

    #一次開発には期日現金は含まれないのでデフォルトで翌営業日が入るようにします。
    if site
      site.update(
        site_designation_method: designation_method,
        holiday_transfer_method: following_business_day,
        setting_type: 0
      )
    else
      site = model.create(
        site_designation_method: designation_method,
        contract_credit_category: category,
        holiday_transfer_method: following_business_day,
        site_designation_method: designation_method,
        setting_type: 0
      )
    end

    case designation_method
    when model.site_designation_method.no_designation
      site.update(day: 0, month: 0, after_day: 0)
    when model.site_designation_method.month_day
      month = site_params[:month]
      day = site_params[:day]
      site.update(month: month, day: day, after_day: 0)
    when model.site_designation_method.after_day
      after_day = site_params[:after_day]
      site.update(month: 0, day: 0, after_day: after_day)
    end

    return site
  end

  def site_date_to_s(site)
    site_str = ''
    if site.site_designation_method == model.site_designation_method.month_day.value
      if site.day && site.day
        site_str = sprintf("%dヶ月後 %d日", site.month, site.day)
      end
    else
      if site.after_day
        site_str = sprintf("%d日後", site.after_day)
      end
    end

    return site_str
  end

  def localize_attr(attr)
    if attr.presence
      return DefaultPayableSite.human_attribute_name(attr)
    else
      return ''
    end
  end

  def localize_option(option_name, option_value)
    option_name = option_name.to_s if option_name.is_a? Symbol
    option_value = option_value.to_s if option_value.is_a? Symbol
    value = (DefaultPayableSite.send(option_name) rescue nil).try(option_value)
    text = t(value, scope: "enumerize.default_payable_site.#{option_name}") if value
    return text.presence || ''
  end
end
