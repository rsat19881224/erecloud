class Journals::JournalDataController < BaseController
  def search
    @q = SlipHeader.search
  end
  def confirm
    @q = SlipHeader.search(search_params)
    @result = @q.result(distinct: true)
  end

  private
  def search_params
    submit_params = params.require(:q).permit(
      :journalizing_slip_date_gteq,
      :journalizing_slip_date_lteq,
      :bill_data_type_eq,
      :slip_detail_trader_code_gteq,
      :slip_detail_trader_code_lteq,
      :bill_ebill_receivable_states_trader_id_gteq,
      :slip_detail_trader_code_lteq
    )
  end
end
