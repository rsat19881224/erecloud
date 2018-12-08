$ ->
  # 検索画面、集計期間選択時
  $("[id^=period_type_]").on 'change', ->
    toggleAllowedPeriodDay()

  # 戻ったとき
  toggleAllowedPeriodDay()

  # 割引取消選択時のみ割引申込日と割引日付を入力可にする
  $("input[name='q[state_code_id_eq]']").on 'ifChecked', ->
    # 割引処理を選択しているか判定する
    processSelect = $("input[name='q[state_code_id_eq]']").eq(0).val() is $(@).val()
    toggleAllowedDiscountDay processSelect

# 割引申込日と割引日付を切替
toggleAllowedDiscountDay = (value) ->
  $("#q_transferred_on_gteq").prop("disabled", value)
  $("#q_transferred_on_lteq").prop("disabled", value)
  $("#q_transferee_trader_id_gteq").prop("disabled", value)
  $("#q_transferee_trader_id_lteq").prop("disabled", value)
  # 日付を削除
  if value
    $("#q_transferred_on_gteq").val('')
    $("#q_transferred_on_lteq").val('')
    $("#q_transferee_trader_id_gteq").val('')
    $("#q_transferee_trader_id_lteq").val('')

# 検索画面、集計期間選択によって日付入力切替
toggleAllowedPeriodDay = ->
  $("[id^=period_type_]").each ->
    id = $(@).attr('id').slice(-1)
    $("#period_#{id}_from").prop('disabled', $(@).val() == '1')
    $("#period_#{id}_to").prop('disabled', $(@).val() == '1')

# 選択した件数と割引金額を表示
$ ->
  # 選択チェック状態変更時
  $("input[name='q[id_eq_any][]']").on 'ifToggled', ->
    showSelectNumberAmount()
    selectCheck()

  # 割引入力画面に戻ったとき
  if $("input[name='q[id_eq_any][]']").size() > 0
    showSelectNumberAmount()
    selectCheck()

#選択した件数と割引金額を表示
showSelectNumberAmount = ->
  $("#select_number").text($(":checked").length + '件')
  $("#select_amount").text(discountAmount())

# 割引金額計算
discountAmount = ->
  money = 0
  $("input[type='checkbox']:checked").each ->
    val = $(@).val()
    money += parseInt($("#money#{val}").text().replace(/[^0-9]/g, ''))
  # 3桁のカンマ区切りに整形して合計金額を返却する
  money = money.toString().replace(/(\d+)(\d{3})/, '$1,$2') while /(\d+)(\d{3})/.test money
  money

$ ->
  # 全選択ボタン押下
  $("#check_all").on 'click', ->
    $('[name="q[id_eq_any][]"]').iCheck('check')
  # 全解除ボタン押下
  $("#cancel_all").on 'click', ->
    $('[name="q[id_eq_any][]"]').iCheck('uncheck')

# 選択チェックボックスが1つ以上オンの場合に、「次へ」ボタンを押下可能に
selectCheck = ->
  if $('[name="q[id_eq_any][]"]:checked').length > 0
    $("#transfer_select_button").prop("disabled", false)
  else
    $("#transfer_select_button").prop("disabled", true)

$ ->
  # キャンセル押下
  $("#select_cancel").on 'click', ->
    # 検索画面リロード
    transition_url = location.href.split("?").shift()
    location.href = transition_url

  # ラジオボタン選択
  $("[name='transferee_code_use']").on 'ifChecked', ->
    transfereeInputToggle($(@).val() == '1')

  # 戻った場合
  transfersInputCheck()
  transfereeInputToggle($("[name='transferee_code_use']").val() == '1')

  # 譲渡日付、譲渡先の入力を監視
  $("#transfer_company_bank_id, #transfer_transferred_on").on 'blur', ->
    transfersInputCheck()

  # 取引先コードの入力を監視
  $("#transfer_trader_attributes_code").on 'change', ->
    $.ajax(
      type: 'GET'
      url: '/receivables/transfers/trader_search'
      data: {
        trader_code: $(@).val()
      }
    ).done (data) ->
      transfereeInformationSet(data)

  # 自社譲渡銀行の入力を監視
  $("#transfer_company_bank_attributes_code").on 'change', ->
    $.ajax(
      type: 'GET'
      url: '/receivables/transfers/company_bank_search'
      data: {
        company_bank_code: $(@).val()
      }
    ).done (data) ->
      transfereeInformationSet(data)

  # 自社譲渡チェックボックス
  $("#company_banks").on 'ifChanged', ->
    check = $(@).prop('checked')
    $("#transfer_company_bank_attributes_code").prop('disabled', !check)
    $("#transfer_trader_attributes_code").prop('disabled', check)
    $("[name='transferee_code_use']").prop('disabled', check)
    $("#transfer_trader_attributes_name").prop('readonly', check)
    $("#transfer_trader_attributes_kana").prop('readonly', check)
    $("#transfer_trader_attributes_bank_code").prop('readonly', check)
    $("#transfer_trader_attributes_account_type").prop('readonly', check)
    $("#transfer_trader_attributes_account_number").prop('readonly', check)
    $("#transfer_trader_attributes_user_number").prop('readonly', check)
    $("#transfer_trader_attributes_branch_code").prop('readonly', check)

    if check
      $("#transfer_trader_attributes_code").val('').trigger('change',[true])
    else
      $("#transfer_company_bank_attributes_code").val('').trigger('change',[true])

# 譲渡日付、譲渡先が入力済みの場合に、「次へ」ボタンを押下可能に
transfersInputCheck = ->
  $("#select_submit").prop("disabled", false)
  if $("#transfer_company_bank_id").val().length == 0 or $("#transfer_transferred_on").val().length == 0
    $("#select_submit").prop("disabled", true)

transfereeInputToggle = (argument) ->
  $("#transfer_trader_attributes_code").prop('disabled', argument)
  $("#transfer_trader_attributes_name").prop('readonly', !argument)
  $("#transfer_trader_attributes_kana").prop('readonly', !argument)
  $("#transfer_trader_attributes_bank_code").prop('readonly', !argument)
  $("#transfer_trader_attributes_account_type").prop('readonly', !argument)
  $("#transfer_trader_attributes_account_number").prop('readonly', !argument)
  $("#transfer_trader_attributes_user_number").prop('readonly', !argument)
  $("#transfer_trader_attributes_branch_code").prop('readonly', !argument)

# 譲渡先情報にセット
transfereeInformationSet = (data) ->
  $("#transfer_trader_attributes_name").val(data.name)
  $("#transfer_trader_attributes_kana").val(data.kana)
  $("#transfer_trader_attributes_bank_code").val(data.bank_code)
  $("#transfer_trader_attributes_branch_code").val(data.branch_code)
  $("#transfer_trader_attributes_account_number").val(data.account_number)
  $("#transfer_trader_attributes_user_number").val(data.user_number)
  