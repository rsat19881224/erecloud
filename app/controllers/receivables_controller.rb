class ReceivablesController < BaseController
  include MasterSearch::Initialize
  include MasterSearch::BankSearch
  include MasterSearch::BranchSearch

  before_action :set_receivable, only: [:create]
  search_master_models :bank, :branch

  def new
    @receivable.trader = Receivable::Trader.new 
    @receivable.opt_trader = Receivable::Trader.new()
    @receivable.section_breakdowns = []
    5.times { @receivable.section_breakdowns.push(SectionBreakdown.new) }
    @receivable.guarantors = []
    @receivable.guarantors.push(Guarantor.new)
  end

  def create
    if @instance.save
      render :new
    end

    redirect_to action: :new
  end

  def make_modal
    @bank_q = Bank.search(params[:q])
    @banks  = @bank_q.result.page(params[:page]).per(params[:per_page] ||= 10)
    @branch_q = Branch.search(params[:q])
    @branches = @branch_q.result.page(params[:page]).per(params[:per_page] ||= 10)

    respond_to do |format|
      format.js {render partial: 'make_modal', locals: {index: params[:index]}} if request.xhr?
    end
  end

  def search
    # FIXME: 検索にreceivableを利用するように変更
    @q = ReceivableSearch.search
  end

  def result
    # FIXME: 検索にreceivableを利用するように変更
    @q = ReceivableSearch.search(search_params)
    # 発生日付の昇順でソート
    @q.sorts = 'occurred_on'
    @ReceivableSearches = @q.result(distinct: true)
  end

  private
  def set_receivable
    @instance = Receivable.new(receivable_params)
  end

  def receivable_params
    params.require(:receivable).permit(
      :recording_institution_id,
      :recording_number,
      :accrual_type,
      :trader_id,
      :opt_trader,
      :last_transferred_on,
      :transfer_warrant,
      :occurred_on,
      :due_become_on,
      :settled_on,
      :site_division,
      :company_bank_id,
      :issue_money,
      :ref_no,
      :transfer_restricted,
      :debtors_department_id,
      :operating_item_id,
      :remark1,
      :remark2,
      :remark3,
      :assignor_name,
      :residual_money,
      { section_breakdowns_attributes: [
        :department_money
      ] },
      :traders_attributes,
      :opt_trader_attributes,
      {guarantors_attributes: [
        :trader_id,
        :guarantor_name,
        :guarantor_kana,
        :bank_code,
        :bank_kana,
        :branch_code,
        :branch_kana,
        :account_type,
        :account_number,
        :guaranty_recorded_on
      ]}
    )
  end
  def search_params
    submit_params = params.require(:q).permit(
      :settled_on_gteq,
      :settled_on_lteq,
      :trader_id_gteq,
      :trader_id_lteq,
      :residual_money_gteq,
      :residual_money_lteq,
      :company_bank_id_gteq,
      :company_bank_id_eq,
      :recording_institution_id_eq,
      :recording_number_gteq,
      :recording_number_lteq,
      :acquisition_division_eq_any,
      :name_specified,
      :name_specified_words,
      :their_particulars,
      state_code_id_eq_any: []
    )

    # パラメータのセット
    hash_param = set_request_param

    # 検索用モデル作成＆実行
    receivable_search = ReceivableSearch.new(hash_param)
    receivable_search.receivable_search

    # 集計期間検索
    #params_q = period_types(submit_params)
    # 名称指定検索
    #params_q = name_specifieds(params_q)
    # 検索パラメータ
    #{ g: {'0' => { m: 'and', g: { '0' => params_q, '1' =>  particulars_specified_params(params_q) } } } }
  end
  def set_request_param
    param_hash = Hash.new()
    param_hash[:period_type_1] = params[:period_type_1]
    param_hash[:period_type_2] = params[:period_type_2]
    param_hash[:period_1_from] = params[:period_1_from]
    param_hash[:period_2_from] = params[:period_2_from]
    param_hash[:period_1_to] = params[:period_1_to]
    param_hash[:period_2_to] = params[:period_2_to]
    param_hash[:name_specified] = params[:name_specified]
    param_hash[:name_specified_words] = params[:name_specified_words]
    param_hash[:transfer_date_from] = params[:transfer_date_from]
    param_hash[:transfer_date_to] = params[:transfer_date_to]
    param_hash[:transferee_trader_id_from] = params[:transferee_trader_id_from]
    param_hash[:transferee_trader_id_to] = params[:transferee_trader_id_to]
    param_hash[:transferee_name] = params[:transferee_name]
    param_hash[:discount_date_from] = params[:discount_date_from]
    param_hash[:discount_date_to] = params[:discount_date_to]
    
    param_hash
  end
end
