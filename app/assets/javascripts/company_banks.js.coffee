prefix = '#company_bank_'

getCompanyBankJSON = ->
  id = $('#company_bank_id').data('company-bank-id')
  return $.get( "/company_banks/#{id}.json" )

initRadio = ->
  $('.radio-inline div').removeClass('checked')

resetFormValueWhenNew = ->
  initRadio()
  $(':text').val('')
  $("#{prefix}limit_discount_money").val('')

resetFormValueWhenEdit = ->
  rollbackFormValue = (companyBank) ->
    textFormIds =
      [
       'code', 'name', 'bank_code', 'bank_name', 'bank_kana', 'branch_code', 'branch_name',
       'branch_kana', 'account_number', 'account_name_kana', 'limit_discount_money',
       'densai_user_number', 'jemco_user_number', 'jemco_discount_financial_institution_user_number',
       'jemoco_is_indicate_present_guarantee', 'mizuho_user_number', 'smbc_user_number'
      ]

    $("#{prefix}#{id}").val(companyBank[id]) for id in textFormIds

    initRadio()
    accountTypeId = "#account_type_#{companyBank['account_type']}"
    $("#{accountTypeId}").find('div').addClass 'checked'
    jemocoIsIndicatePresentGuaranteeId =
      "#jemoco_is_indicate_present_guarantee_#{companyBank['jemoco_is_indicate_present_guarantee']}"
    $("#{jemocoIsIndicatePresentGuaranteeId}").find('div').addClass 'checked'

  getCompanyBankJSON().done((data) ->
    rollbackFormValue(data)
  ).fail(->
    alert '自社取引銀行情報の取得に失敗しました。'
  )

$ ->
  setupFinancialInstitutionSearch =
    erecloud_require_module('search_modal').setupFinancialInstitutionSearch
  setupFinancialInstitutionSearch(
    '#company_bank_',
    '/company_banks/search_bank',
    '/company_banks/search_branch'
  )

  zeroPaddingAccountNumber = erecloud_require('zeroPaddingAccountNumber')
  $("#{prefix}account_number").on 'blur', ->
    number = $(@).val()
    $(@).val(zeroPaddingAccountNumber(number))

  $("#{prefix}new_cancel").on  'click', resetFormValueWhenNew
  $("#{prefix}edit_cancel").on 'click', resetFormValueWhenEdit
