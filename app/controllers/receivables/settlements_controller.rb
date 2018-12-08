class Receivables::SettlementsController < BaseController

  def new
  end

  def create
  end

  def search
    if params[:back]
      @q = ReceivableSearch.search(session[:search_condition])
      @aggregate_scope = session[:aggregate_scope]

    else
      # 戻る押下時
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
      session[:search_condition] = search_query(search_params)
      session[:aggregate_scope] = set_request_param
      # 選択したidをsessionから削除
      session[:select_ids] = nil
    end
    @q = ReceivableSearch.search(session[:search_condition])
    @receivable_searches = @q.result(distinct: true)
  end

  def select
    unless params[:back]
      # 選択したidをsessionに保持
      session[:select_ids] = select_params
      # 入力した手数料をsessionから削除
      session[:input_params] = {}
      session[:receivable_searches] = nil
    end
    @q = ReceivableSearch.search(session[:select_ids])
    @receivable_searches = @q.result(distinct: true)
    @input_params = session[:input_params]
  end

  def confirm
    @q = ReceivableSearch.search(session[:select_ids])
    @receivable_searches = @q.result(distinct: true)
    # 入力した手数料をsessionに保持
    session[:input_params] = input_params

    input_params_zip = input_params[:id].zip(input_params[:fee])
    @receivable_searches.each {|item|
      input_params_zip.each{|elem|
        if item.id == elem.first.to_i
          item.bank_transfer_fee = elem.last.to_i
        end
      }
    }
    @input_params = session[:input_params]
    session[:receivable_searches] = @receivable_searches
  end

  def update_all
  end

  private
  def search_params
    submit_params = params.require(:q).permit(
      :settled_on_gteq,
      :settled_on_lteq,
      :trader_id_gteq,
      :trader_id_lteq,
      :residual_money_gteq,
      :residual_money_lteq,
      :company_bank_id_gteq,
      :company_bank_id_lteq,
      :recording_institution_id_eq,
      :recording_number_gteq,
      :recording_number_lteq,
      :acquisition_division_eq_any,
      :name_specified,
      :name_specified_words,
      :their_particulars,
      state_code_id_eq_any: []
    )
  end

  def search_query(args_param)
    # パラメータのセット
    hash_param = set_request_param
    # 検索クエリの作成
    receivable_search = ReceivableSearch.new(hash_param)
    settlement_query = receivable_search.settlement_search

    args_param.merge(settlement_query)
  end

  def set_request_param
    param_hash = Hash.new()

    param_hash[:cancel_flag] = params[:cancel_flag]
    param_hash[:recording_institutions_check] = params[:recording_institutions_check]
    param_hash[:period_type_1] = params[:period_type_1]
    param_hash[:period_type_2] = params[:period_type_2]
    param_hash[:period_1_from] = params[:period_1_from]
    param_hash[:period_2_from] = params[:period_2_from]
    param_hash[:period_1_to] = params[:period_1_to]
    param_hash[:period_2_to] = params[:period_2_to]

    param_hash
  end
  def select_params
    select_params = params.require(:q).permit(id_eq_any: [])
  end
  def input_params
    input_params = params.require(:settlement).permit(
      fee: [],
      id: [])
  end
end
