prefix = '#trader_trader_bank_account_attributes_'
accountTypeValues = [1,2,9]
zeroPaddingAccountNumber = erecloud_require('zeroPaddingAccountNumber')
textFormSuffixes = [
  'bank_code', 'bank_name', 'bank_kana', 'branch_code', 'branch_name', 'branch_kana',
  'account_number', 'account_name_kana', 'edi_code1', 'edi_code2', 'densai_user_number',
  'jemco_user_number', 'jemco_payment_number'
]

###*
 * 新規作成時のキャンセルの処理を行うための関数を生成する関数
 * @param {string} childIndex - nested_formにより付番されるchild_index
 * @return {Function} - childIndexに対応するキャンセルの処理を行う関数
###
generateNewModeCanceler = (childIndex) ->
  ->
    prefix = "#trader_trader_bank_accounts_attributes_#{childIndex}_"
    $("#{prefix}#{suffix}").val('') for suffix in textFormSuffixes

    $("#{prefix}account_type_#{atv}").iCheck('uncheck') for atv in accountTypeValues

    $("#{prefix}densai_is_priority_false").iCheck('check')
    $("#{prefix}jemco_is_priority_false").iCheck('check')

###*
 * 編集時のキャンセル処理を行うための関数を生成する関数
 * @param {string} childIndex - nested_formにより付番されるchild_index
 * @return {Function} - childIndexに対応するキャンセルの処理を行う関数
###
generateEditModeCanceler = (childIndex) ->
  ->
    prefix = "#trader_trader_bank_accounts_attributes_#{childIndex}_"
    bankAccount = $("#data_trader_bank_account_#{childIndex}").data('json')
    $("#{prefix}#{column}").val(bankAccount[column]) for column in textFormSuffixes

    if bankAccount['accountType'] is ''
      $("#{prefix}account_type_#{atv}").iCheck('uncheck') for atv in accountTypeValues
    else
      $("#{prefix}account_type_#{bankAccount['account_type']}").iCheck('check')
    $("#{prefix}densai_is_priority_#{bankAccount['densai_is_priority']}").iCheck('check')
    $("#{prefix}jemco_is_priority_#{bankAccount['jemco_is_priority']}").iCheck('check')

###*
 * numericなコードを入力するフォームの入力制御を行う。nested_formで動的に生成された要素に対応するためにフィールドを引数として受け取る。
 * @param {Element} formField - 入力制御対象のフォームが配置されているフィールド
###
numericCodeConrol = (formField) ->
  $(formField).find('[id$=bank_code],[id$=branch_code],[id$=account_number]').on 'blur keyup paste', ->
    code = $(@).val()
    $(@).val(code.replace /[^0-9]+/g, '')

  $(formField).find('[id$=account_number]').on 'blur', ->
    number = $(@).val()
    unless number is ''
      number = number.replace(/[^0-9]+/g, '')
      $(@).val(zeroPaddingAccountNumber(number))

###
 * キャンセルボタンへ適切なキャンセル処理を行う関数をバインドするための関数
 * @param {Element} cancelButton - バインドしたいキャンセルボタンのオブジェクト
###
bindChancelAction = (cancelButton, mode) ->
  cancelButtonId = $(cancelButton).attr('id')
  childIndex = cancelButtonId.replace /[^0-9]+/g, ''
  if mode is 'new'
    canceler = generateNewModeCanceler(childIndex)
  else
    canceler = generateEditModeCanceler(childIndex)
  $(cancelButton).on 'click', -> canceler()

###*
 * numericなコードを入力するフォームの入力制御を行う。nested_formで動的に生成された要素に対応するためにフィールドを引数として受け取る。
 * @param {Element} formField - 入力制御対象のフォームが配置されているフィールド
###
numericCodeConrol = (formField) ->
  $(formField).find('[id$=bank_code],[id$=branch_code],[id$=account_number]').on 'blur keyup paste', ->
    code = $(@).val()
    $(@).val(code.replace /[^0-9]+/g, '')

  $(formField).find('[id$=account_number]').on 'blur', ->
    number = $(@).val()
    unless number is ''
      number = number.replace(/[^0-9]+/g, '')
      $(@).val(zeroPaddingAccountNumber(number))

$ ->
  currentAction =
    do ->
      path = location.pathname.split('/')
      path[path.length - 1]

  # キャンセルボタンとnumericな値の入力フォームの制御の追加
  traderBankAccountsForms = $('#trader_bank_accounts').find('.fields')
  for form in traderBankAccountsForms
    cancelButton = $(form).find('[id^=trader_bank_accounts_][id$=_cancel]')
    bindChancelAction(cancelButton, currentAction) if cancelButton
    numericCodeConrol(form)

  # nested_formで追加されたフィールド内のキャンセルボタンとnumericな値の入力フォームの制御の追加
  $(document).on 'nested:fieldAdded', (e) ->
    field = e.field
    cancelButton = $(field).find("[id^=trader_bank_accounts_][id$=_cancel]")
    bindChancelAction(cancelButton, 'new') if cancelButton
    numericCodeConrol(field)
