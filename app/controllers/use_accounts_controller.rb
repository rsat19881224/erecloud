class UseAccountsController < BaseController
  permit_attributes :code, :name, :department_input, :input_division, :analysis1_input
  skip_before_action :load_objects

  def index
    account_q = Account.search(company_id_eq: @my_company.id)
    account_q.sorts = 'id asc'
    @account = account_q.result

    analysis_division_q = AnalysisDivision.search(company_id_eq: @my_company.id, used_eq: true)
    analysis_division_q.sorts = 'id asc'
    @analysis_division = analysis_division_q.result
  end 
end
