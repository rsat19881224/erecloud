class OperativeSettingsController < BaseController
  before_action :load_object
  before_action :control_panel

  permit_attributes(
    :company_name1, :company_name2, :postal_code, :address1, :address2, :company_number,
    :representative_name, :representative_official_title, :person_in_charge_name,
    :person_in_charge_official_title, :date_display_format, :is_transfer_fixed_date,
    :is_use_section_authority
  )

  def control_panel
    set_option_assets

    if (params[:operative_setting] || {}).try(:control_mode) == 'edit'
      assign_content_title('edit')
      @current_control_mode = 'edit'
    else
      assign_content_title('show')
      @current_control_mode = 'show'
    end

    respond_to do |format|
      case request.method
      when 'POST'
        if @instance.save
          format.html { redirect_to redirect_path, notice: t(:successfully_updated, model: model.model_name.human, scope: [:views, :messages]) }
        else
          format.html { render action: :control_panel }
        end
      when 'GET'
        format.html
        format.json
      end
    end
  end

  private
  def redirect_path
    operative_settings_control_panel_path
  end

  def set_option_assets
    self.option_stylesheet_links = ['default_payable_sites']
    self.option_javascript_includes = ['default_payable_sites']
  end

  def load_object
    @instance = OperativeSetting.of_ours(@my_company).first.presence || model.pre_create_operative_setting(@my_company)
    @operative_setting = @instance.tap do |instance|
      instance.try(:assign_attributes, permitted_parameters)
    end
  end

  def assign_content_title(action)
    params[:content_title] = t('titles.operative_settings')
    params[:content_small_title] = t(action, scope: 'small_titles.operative_settings')
  end
end
