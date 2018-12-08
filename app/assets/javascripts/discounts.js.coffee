$ ->
# カレンダー日付入力
  $('.inputCalendars').setCalendar()

  # 検索画面キャンセル押下
  $("#search_cancel").on 'click', ->
    # 検索画面リロード
    transition_url = location.href.split("?").shift()
    location.href = transition_url

  # 検索画面に戻ったとき
  if $("input[name='q[state_code_id_eq]']").size() > 0
    # 割引処理を選択しているか判定する
    processSelect = $("input[name='q[state_code_id_eq]']").eq(0).val() is $("input[name='q[state_code_id_eq]']:checked").val()
    toggleAllowedDiscountDay processSelect
    toggleAllowedPeriodDay()

  # 割引取消選択時のみ割引申込日と割引日付を入力可にする
  $("input[name='q[state_code_id_eq]']").on 'ifChecked', ->
    # 割引処理を選択しているか判定する
    processSelect = $("input[name='q[state_code_id_eq]']").eq(0).val() is $(@).val()
    toggleAllowedDiscountDay processSelect

  # 戻った場合
  bunkInputCheck()
  # 自社取引銀行の入力を監視
  $("#q_company_bank_id_eq").on 'change', ->
    bunkInputCheck()

  # 検索画面、集計期間「指定なし」選択時
  $("[id^=period_type_]").on 'change', ->
   toggleAllowedPeriodDay()

# 割引申込日と割引日付を切替
toggleAllowedDiscountDay = (value) ->
  $("#q_discount_requested_on_gteq").prop("disabled", value)
  $("#q_discount_requested_on_lteq").prop("disabled", value)
  $("#q_transferred_on_gteq").prop("disabled", value)
  $("#q_transferred_on_lteq").prop("disabled", value)
  # 日付を削除
  if value
    $("#q_discount_requested_on_gteq").val('')
    $("#q_discount_requested_on_lteq").val('')
    $("#q_transferred_on_gteq").val('')
    $("#q_transferred_on_lteq").val('')

# 検索画面、集計期間選択によって日付入力切替
toggleAllowedPeriodDay = ->
  $("[id^=period_type_]").each ->
    id = $(@).attr('id').slice(-1)
    $("#period_#{id}_from").prop('disabled', $(@).val() == '1')
    $("#period_#{id}_to").prop('disabled', $(@).val() == '1')

# 自社取引銀行が入力済みの場合に、「次へ」ボタンを押下可能に
bunkInputCheck = ->
  if $("#q_company_bank_id_eq").val() > 0
    $("#search_submit").prop("disabled", false)
  else
    $("#search_submit").prop("disabled", true)

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
    $("#discount_select_button").prop("disabled", false)
  else
    $("#discount_select_button").prop("disabled", true)

$ ->
  # 戻ったとき
  inputCheck()
  # 割引日、割引料の入力イベントを監視
  $("#discount_requested_on, #discount_transferred_on").on 'blur', ->
    unless discountDateCheck($(@).val())
      $(@).val('')
    inputCheck()

discountDateCheck = (input_date) ->
  # 一番早い支払期日
  min_matured_on = null
  $("[id^=matured_on]").each ->
    if min_matured_on is null
      min_matured_on = $(@).text()
    else if Date.parse(min_matured_on) > Date.parse($(@).text())
      min_matured_on = $(@).text()
  # 一番早い発生日
  min_occurred_on = null
  $("[id^=occurred_on]").each ->
    if min_occurred_on is null
      min_occurred_on = $(@).val()
    else if Date.parse(min_occurred_on) > Date.parse($(@).val())
      min_occurred_on = $(@).val()

  # 入力値が直近の支払期日以降の場合
  today = new Date()
  today_date = today.getFullYear() + "/" + (today.getMonth() + 1).toString() + "/" +  today.getDate().toString()

  unless Date.parse(today_date) <= Date.parse(input_date) <= Date.parse(min_matured_on)
    return false
  # 入力値が直近の発生日より前の場合
  if Date.parse(input_date) < Date.parse(min_occurred_on)
    return false
  return true

# 割引日、割引料が入力済みの場合に次へボタンを活性化
inputCheck = ->
  if $("#discount_requested_on").val().length == 0 or $("#discount_transferred_on").val().length == 0
    $("#discount_confirm_button").prop("disabled", true)
  else
    $("#discount_confirm_button").prop("disabled", false)