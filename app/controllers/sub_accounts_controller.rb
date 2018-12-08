class SubAccountsController < BaseController
	permit_attributes :code, :name, :kana, :account_id, 
	:tax_division_id, :tax_rate_id, :tax_display, :round, 
	:business_division_id

	def index
      selected_account_id = params[:selected_account_id]

      if request.xhr?
        params_id = params[:selected_account_id].to_s
      else
        accout_q = Account.search(company_id_eq: @my_company.id)
        accout_q.sorts = 'code asc'
        @account = accout_q.result.presence.try(:first)

        if @account.nil?
          params_id = nil
        else
          params_id = @account[:id].to_s
        end 
      end
      binding.pry
      sub_account_p = SubAccount.search(account_id_eq: params_id)
  	  @sub_account = sub_account_p.result 
    
      respond_to do |format|
        if selected_account_id
          format.js { render 'index', locals: {accounts: @sub_account, pickup_param: @pickup_param, params_id: params_id} }  # if request.xhr?
        else
          format.html { render 'index', locals: {accounts: @sub_account, pickup_param: @pickup_param, params_id: params_id} }
        end
      end
	end
end
