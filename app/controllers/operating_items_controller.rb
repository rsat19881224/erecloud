class OperatingItemsController < BaseController
  permit_attributes :operating_division_id, :name, :kana, :abbreviation, :code

  def index
  	
    selected_division_no = params[:selected_division_no]

    if request.xhr?
      params_id = params[:selected_division_no].to_s
    else
      operating_division = OperatingDivision.search(company_id_eq: @my_company.id, used_eq: true)
      operating_division.sorts = 'code asc'
      @operating_division = operating_division.result.presence.try(:first)
      
      if @operating_division.nil?
        params_id = nil
      else
        params_id = @operating_division[:id].to_s
      end 
    end

  	operating_item_q = OperatingItem.search(operating_division_id_eq: params_id)
    @operating_item = operating_item_q.result
    
    respond_to do |format|
      if selected_division_no
        format.js { render 'index', locals: {items: @operating_item, pickup_param: @pickup_param} }  # if request.xhr?
      else
        format.html { render 'index', locals: {items: @operating_item, pickup_param: @pickup_param, params_id: params_id} }
      end
    end
  end
end
