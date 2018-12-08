$ ->
  # キャンセル押下
  $("#cancel").on 'click', ->
    # 検索画面リロード
    transition_url = location.href.split("?").shift()
    location.href = transition_url

  # 債権種別プルダウン変更時
  $("[id^=q_bill_data_type_eq]").on 'change', ->
    # TODO:
    if $('#q_bill_data_type_eq option:selected').text() is '受取手形'
      $('#q_bill_ebill_receivable_states_own_state_id_eq').prop("disabled", false)
    else
      $('#q_bill_ebill_receivable_states_own_state_id_eq').prop("disabled", true)

  # 全選択ボタン押下
  $("#check_all").on 'click', ->
    $('[name="q[id_eq_any][]"]').iCheck('check')
  # 全解除ボタン押下
  $("#cancel_all").on 'click', ->
    $('[name="q[id_eq_any][]"]').iCheck('uncheck')

  # 選択チェック状態変更時
  $("input[name='q[id_eq_any][]']").on 'ifToggled', ->
    selectCheck()


# 選択チェックボックスが1つ以上オンの場合に、「次へ」ボタンを押下可能に
selectCheck = ->
  if $('[name="q[id_eq_any][]"]:checked').length > 0
    $("#journal_output_button").prop("disabled", false)
  else
    $("#journal_output_button").prop("disabled", true)
