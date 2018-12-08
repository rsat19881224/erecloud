class Receivables::DiscountsController < BaseController
  def search
    if params[:back]
      # 戻る押下時
      @q = ReceivableSearch.search(session[:search_condition])
      @aggregate_scope = session[:aggregate_scope]
    else
      @q = ReceivableSearch.search
      # 検索条件をsessionから削除
      session[:search_condition] = nil
      session[:aggregate_scope] = nil
    end
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
    @q = ReceivableSearch.search(session[:search_condition])
    @receivable_searches = @q.result(distinct: true)
    @search_institution_bank = recording_institution_bank
  end

  def select
    if params[:back]
      # 戻る押下時
      @input_params = session[:input_params]
    else
      # 選択したidをsessionに保持
      session[:select_ids] = select_params
      # 入力した割引日付と手数料をsessionから削除
      session[:input_params] = nil
    end
    @q = ReceivableSearch.search(session[:select_ids])
    @receivable_searches = @q.result(distinct: true)
    @search_institution_bank = recording_institution_bank
  end
  def confirm
    @q = ReceivableSearch.search(session[:select_ids])
    @receivable_searches = @q.result(distinct: true)
    @search_institution_bank = recording_institution_bank
    # 入力した割引日付と手数料をsessionに保持
    session[:input_params] = input_params
    @input_params = session[:input_params]
  end
  def update_all
  end
  private
  def search_params
    submit_params = params.require(:q).permit(
      :state_code_id_eq,
      :recording_institution_id_eq,
      :company_bank_id_eq,
      :trader_id_gteq,
      :trader_id_lteq,
      :residual_money_gteq,
      :residual_money_lteq,
      :company_bank_id_gteq,
      :discount_requested_on_gteq,
      :discount_requested_on_lteq,
      :transferred_on_gteq,
      :transferred_on_lteq
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
  def input_params
    input_params = params.require(:discount).permit(
      :requested_on,
      :transferred_on,
      discount_charge: [],
      bank_transfer_fee: [],
      id: [])
  end

  def recording_institution_bank
    return_param = Hash.new
    return_param[:recording_institution] = RecordingInstitution.where(code: session[:search_condition]['recording_institution_id_eq']).pluck(:abbreviation).first
    return_param[:bank] = CompanyBank.where(code: session[:search_condition]['company_bank_id_eq']).pluck(:code, :name, :bank_code, :bank_name, :branch_code, :branch_kana, :account_type, :account_number).first
    return_param[:bank][6] = t(Settings.enumerize_options.company_bank.account_types.select{|at| at.id == return_param[:bank][6].to_i}.first[:name])
    return_param
  end
end
