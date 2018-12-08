$(document.body).append('<%=
  render partial: "shared/banks/search_form",
  locals: {
    modalid: "search_bank_guarantors_attributes_#{index}_modal_form",
    resultid: "search_bank_guarantors_attributes_#{index}_modal_result",
    target_controller_name: "trader_bank_accounts"}%>')

$(document.body).append('<%=
  render partial: "shared/branches/search_form",
    locals: {
      modalid: "search_branch_guarantors_attributes_#{index}_modal_form",
      resultid: "search_branch_guarantors_attributes_#{index}_modal_result",
    target_controller_name: "trader_bank_accounts"}%>')
