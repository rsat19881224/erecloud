# -*- coding: utf-8 -*-
class TradersController < BaseController
  before_action :set_option_assets
  before_action :create_search_object, only: [:search, :edit_or_delete, :site]
  before_filter :set_edit_request_uri, only: [:edit]

  def new
    @trader.build_initial_representation_of_data
    @trader.trader_bank_accounts = [TraderBankAccount.new]
    @instance = @trader
    @initial_representation_of_data = @trader.initial_representation_of_data
    @trader_bank_accounts = @trader.trader_bank_accounts
  end

  def edit
    @trader = Trader.find(params[:id])
    @initial_representation_of_data = @trader.initial_representation_of_data || @trader.build_initial_representation_of_data
    if @trader.trader_bank_accounts.blank?
      @trader.trader_bank_accounts = [TraderBankAccount.create(trader_id: @trader.id)]
    end
  end

  def create
    @trader = Trader.new(trader_params.merge({company_id: @my_company.id}))
    create_or_update
  end

  def update
    create_or_update
  end

  def edit_or_delete
    respond_to do |format|
      format.html { render 'search', locals: {search_kind: @search_kind} }
    end
  end

  def site
    respond_to do |format|
      format.html { render 'search', locals: {search_kind: @search_kind} }
    end
  end

  private
  def create_search_object
    @trader_q = Trader.search(params[:q])
    @trader_q.sorts = ['code asc']
    @traders = @trader_q.result.page(params[:page]).per(10)
    if params[:search_kind]
      @search_kind = params[:search_kind]
    else
      @search_kind = action_name
    end
  end

  def create_or_update
    respond_to do |format|
      completed = Proc.new {
        # 更新時のみ子のidが正当なものか検証する
        if action_name == 'edit'
          next false unless valid_id_params?
        end

        next false unless @trader.update_attributes(trader_params)

        # 自社取引銀行のパラメータの生成
        ird_params = params[:trader][:initial_representation_of_data_attributes]
        if ird_params.present?
          ird_company_bank_params = make_ird_company_bank_params(ird_params)
          if ird_company_bank_params.present?
            next false unless @trader.initial_representation_of_data.update_attributes(ird_company_bank_params)
          end
        end

        next true
      }.call

      if completed
        format.html { redirect_to redirect_path }
      else
        format.html { render (action_name == 'new' ? 'new' : 'edit') }
      end
    end
  end

  def check_id_params
    ird_params = params[:trader][:initial_representation_of_data_attributes]
    tba_params = params[:trader][:trader_bank_accounts_attributes]

    ird_id = ird_params[:id].to_i
    all_ird_ids = InitialRepresentationOfData.all.map &:id
    if @trader.initial_representation_of_data.id != ird_id && all_ird_ids.include?(ird_id)
      @trader.errors[:base] << 'システムエラー: 初期表示設定IDが不正です。'
      return false
    end

    tba_ids = @trader.trader_bank_accounts.map &:id
    all_tba_ids = TraderBankAccount.all.map &:id
    tba_params.each do |id, attr_params|
      id = attr_params[:id].to_i
      if !tba_ids.include?(id) && all_tba_ids.include?(id)
        @trader.errors[:base] << 'システムエラー： 取引先口座情報IDが不正です。'
        return false
      end
    end

    return true
  end

  # リクエト元のページのURIをセッションに保存
  def set_edit_request_uri
    session[:edit_trader_request_uri] = URI(request.referer)
  end

  def redirect_path
    if action_name == 'edit'
      request_uri = session[:edit_trader_request_uri]
      request_uri.present? ? request_uri : edit_or_delete_traders_path
    else
      new_trader_path
    end
  end

  # 会社銀行はUI上では会社銀行コード入力だが、DB上ではidなので変換を行う
  def make_ird_company_bank_params(ird_params)
    ird_company_bank_params = {}
    ird_params.each_pair do |key, value|
      if key.to_s.match(/company_bank/) && value[:code].present?
        if company_bank = CompanyBank.search(code_eq: value[:code]).result.first
          ird_company_bank_params["#{key}_id"] = company_bank.id.to_s
        end
      end
    end

    return ird_company_bank_params
  end

  # 初期表示設定と取引先口座情報のjsとcssを読み込む
  def set_option_assets
    self.option_stylesheet_links = [
      'initial_representation_of_data',
      'trader_bank_accounts',
      'default_payable_sites'
    ]
    self.option_javascript_includes = [
      'initial_representation_of_data',
      'trader_bank_accounts',
      'default_payable_sites'
    ]
  end

  def trader_params
    (params.require(:trader) rescue params).permit(
      :code,
      :corporation_number,
      :name1,
      :name2,
      :kana,
      :short_name,
      :postal_code,
      :address1,
      :address2,
      :person_in_charge_official_title,
      :person_in_charge_name,
      :tel,
      :fax,
      :email,
      :reference_type,
      :customer_code,
      :vendor_code,
      :is_make_jounalizing,
      { initial_representation_of_data_attributes: [
          :id,
          :trader_id,
          :pbill_mailing_division,
          :pbill_postage_division,
          :pbill_postage,
          :receipt_postage,
          :rbill_drawing_bank_code,
          :rbill_drawing_bank_name,
          :rbill_drawing_branch_code,
          :rbill_drawing_branch_name,
          :pbill_company_bank_id,
          :ebill_settling_company_bank_id,
          :ebill_payment_company_bank_id,
          :rfactoring_company_bank_id,
          :pfactoring_company_bank_id,
          :bank_transfer_receipt_company_bank_id,
          :bank_transfer_payment_company_bank_id,
          :_destroy
        ]
      },
      { trader_bank_accounts_attributes: [
          :id,
          :trader_id,
          :bank_code,
          :bank_name,
          :bank_kana,
          :branch_code,
          :branch_name,
          :branch_kana,
          :account_type,
          :account_number,
          :account_kana,
          :edi_code1,
          :edi_code2,
          :densai_user_number,
          :densai_is_priority,
          :jemco_user_number,
          :jemco_peyment_number,
          :jemco_is_priority,
          :_destroy
        ]
      }
    )
  end
end
