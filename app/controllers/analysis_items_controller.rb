class AnalysisItemsController < BaseController
  permit_attributes :analysis_division_id, :name, :abbreviation, :kana, :code, :division_no
  
  def index
    selected_division_no = params[:selected_division_no]

    if request.xhr?
      params_id = params[:selected_division_no].to_s
    else
      
      analysis_division_q = AnalysisDivision.search(company_id_eq: @my_company.id, used_eq: true)
      analysis_division_q.sorts = 'id asc'
      @analysis_division = analysis_division_q.result.presence.try(:first)
      
      if @analysis_division.nil?
        params_id = nil
      else
        params_id = @analysis_division[:id].to_s
      end 
    end
    
    analysis_item_q = AnalysisItem.search(analysis_division_id_eq: params_id)
    @analysis_item = analysis_item_q.result
  	
    respond_to do |format|
      if selected_division_no
        format.js { render 'index', locals: {analysises: @analysis_item, pickup_param: @pickup_param} }  # if request.xhr?
      else
        format.html { render 'index', locals: {analysises: @analysis_item, pickup_param: @pickup_param, params_id: params_id} }
      end
    end
  end

end
