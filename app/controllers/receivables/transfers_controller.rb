class Receivables::TransfersController < BaseController

  def select
    if params[:back]
      # 戻る押下時
      @instance = Transfer.new(session[:transfer_params])
    else
      @instance = Transfer.new
      @instance.trader = Transfer::Trader.new
      @instance.company_bank = Transfer::CompanyBank.new
      session[:transfer_params] = nil
      session[:recording_institution] = nil
      session[:own_bank] = nil
      session[:transferee_bank] = nil
    end
  end
  def trader_search
    trader = Trader.where(code: params[:trader_code]).first
    trader_bank = TraderBankAccount.where(trader_id: trader.try(:id)).first
    @json = {name: trader.try(:name1),
             kana: trader.try(:kana),
             bank_code: trader_bank.try(:bank_code),
             branch_code: trader_bank.try(:branch_code),
             account_type: trader_bank.try(:account_type),
             account_number: trader_bank.try(:account_number),
             user_number: trader_bank.try(:ebill_user_number)}
    render json: @json.to_json and return if request.xhr?
  end
  def company_bank_search
    company_bank = CompanyBank.where(company_id: current_user.company_id, code: params[:company_bank_code]).first
    @json = {name: company_bank.try(:name),
             kana: company_bank.try(:account_name_kana),
             bank_code: company_bank.try(:bank_code),
             branch_code: company_bank.try(:branch_code),
             account_type: company_bank.try(:account_type),
             account_number: company_bank.try(:account_number),
             user_number: company_bank.try(:user_number)}
    render json: @json.to_json and return if request.xhr?
  end
  def search
    if params[:back]
      # 戻る押下時
      @q = ReceivableSearch.search(session[:search_condition])
      @aggregate_scope = session[:aggregate_scope]
    else
      @q = ReceivableSearch.search
      @instance = Transfer.new(transfer_params)
      # 検索条件をsessionから削除
      session[:search_condition] = nil
      session[:aggregate_scope] = nil
      # 入力した値をsessionに保持
      session[:transfer_params] = transfer_params
      # 記録機関を設定
      session[:recording_institution] = recording_institution
      # 自社取引銀行を設定
      session[:own_bank] = own_bank
      # 譲渡先銀行を設定
      session[:transferee_bank] = transferee_bank
    end
    @instance = Transfer.new(session[:transfer_params])
    @recording_institution = session[:recording_institution]
    @own_bank = session[:own_bank]
    @transferee_bank = session[:transferee_bank]
  end
  def result
    if params[:back]
      # 戻る押下時
      @select_ids = session[:select_ids]
    else
      # 検索条件をsessionに保持
      session[:search_condition] = search_params.merge(search_query)
      session[:aggregate_scope] = set_request_param
      # 選択したidをsessionから削除
      session[:select_ids] = nil
    end
    @instance = Transfer.new(session[:transfer_params])
    @recording_institution = session[:recording_institution]
    @own_bank = session[:own_bank]
    @transferee_bank = session[:transferee_bank]
    @q = ReceivableSearch.search(session[:search_condition])
    @receivable_searches = @q.result(distinct: true)
  end
  def confirm
    @q = ReceivableSearch.search(select_params)
    session[:select_ids] = select_params
    @receivable_searches = @q.result(distinct: true)
    @instance = Transfer.new(session[:transfer_params])
    @recording_institution = session[:recording_institution]
    @own_bank = session[:own_bank]
    @transferee_bank = session[:transferee_bank]
  end
  private
  def transfer_params
    params.require(:transfer).permit(
      :recording_institution_id,
      :trader_id,
      :transferred_on,
      :company_bank_id,
      :guaranteed,
      trader_attributes: [:name, :kana, :bank_code, :branch_code, :account_type, :account_number, :user_number],
      company_bank_attributes: [:code]
    )
  end
  def search_params
    submit_params = params.require(:q).permit(
      :state_code_id_eq,
      :recording_institution_id_eq,
      :company_bank_id_eq,
      :trader_id_gteq,
      :trader_id_lteq,
      :residual_money_gteq,
      :residual_money_lteq,
      :transferred_on_gteq,
      :transferred_on_lteq,
      :transferee_trader_id_gteq,
      :transferee_trader_id_lteq
    )
  end
  def set_request_param
    param_hash = Hash.new()
    param_hash[:period_type_1] = params[:period_type_1]
    param_hash[:period_type_2] = params[:period_type_2]
    param_hash[:period_1_from] = params[:period_1_from]
    param_hash[:period_2_from] = params[:period_2_from]
    param_hash[:period_1_to] = params[:period_1_to]
    param_hash[:period_2_to] = params[:period_2_to]

    param_hash
  end
  def search_query
    receivable_search = ReceivableSearch.new(set_request_param)
    receivable_search.receivable_search
  end
  def select_params
    select_params = params.require(:q).permit(id_eq_any: [])
  end
  # 記録機関検索
  def recording_institution
    RecordingInstitution.where(code: @instance.recording_institution_id).pluck(:abbreviation).first
  end
  # 自社取引銀行検索
  def own_bank
    CompanyBank.where(code: @instance.company_bank_id).pluck(:bank_name, :branch_name, :bank_code, :branch_code, :account_type, :account_number).first
  end
  # 取引先銀行検索
  def transferee_bank
    transferee_bank = Bank.where(code: @instance.trader.bank_code).pluck(:id, :name).first
    branch_name = Branch.where(bank_id: transferee_bank.fetch(0, nil), code: @instance.trader.branch_code).pluck(:name).first
    {bank_name: transferee_bank[1], branch_name: branch_name}
  end
end
