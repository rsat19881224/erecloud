$ ->
  # 検索画面、集計期間「指定なし」選択時
  $("[id^=period_type_]").on 'change', ->
    periodCheck($(@))

  # 検索画面、記録機関を指定するチェックボックス変更時
  $("#recording_institutions_check").on 'ifToggled', ->
    recordingInstitutionCheck($(@).prop('checked'))

  # 検索画面に戻ったとき
  recordingInstitutionCheck($("#recording_institutions_check").prop('checked'))
  $("[id^=period_type_]").each ->
    periodCheck($(@))

  # 検索画面キャンセル押下
  $("#search_cancel").on 'click', ->
    # 検索画面リロード
    transition_url = location.href.split("?").shift()
    location.href = transition_url

  # 保証人情報に
  # 日付フィールドにデートピッカーを付与する
  # 銀行コード補完機能を付与する
  $(document).on("nested:fieldAdded:guarantors", (event) ->
    field = event.field
    number = field.find('.hide').text()
    dateField = field.find('.inputCalendars')
    dateField.setCalendar()

    $.when(
      $.ajax({
        url: '/receivables/make_modal'
        dataType: 'script'
        data: {index: number}}))
    .done(->(
        setupFinancialInstitutionSearch("#receivable_guarantors_attributes_#{number}_", "search_branch", "guarantors_attributes_#{number}"))))

  # 選択チェック状態変更時
  $("input[name='q[id_eq_any][]']").on 'ifToggled', ->
    selectCheck()

  # 戻ったとき
  selectCheck()

  # 全選択ボタン押下
  $("#check_all").on 'click', ->
    $('[name="q[id_eq_any][]"]').iCheck('check')
  # 全解除ボタン押下
  $("#cancel_all").on 'click', ->
    $('[name="q[id_eq_any][]"]').iCheck('uncheck')

# 選択チェックボックスが1つ以上オンの場合に、「次へ」ボタンを押下可能に
selectCheck = ->
  if $('[name="q[id_eq_any][]"]:checked').length > 0
    $("#settlement_select_button").prop("disabled", false)
  else
    $("#settlement_select_button").prop("disabled", true)

periodCheck = (at) ->
  id = at.attr('id').slice(-1)
  if at.val() isnt '1'
    $("#period_#{id}_from").prop('disabled', false)
    $("#period_#{id}_to").prop('disabled', false)
  else
    $("#period_#{id}_from").prop('disabled', true)
    $("#period_#{id}_to").prop('disabled', true)

# チェックボックスの値によって、記録機関プルダウンのdisabledを切替
recordingInstitutionCheck = (flag) ->
  $("#q_recording_institution_id_eq").prop('disabled', !flag)
  # チェックボックスがオフなら記録機関プルダウンを初期値に戻す
  unless flag
    $("#q_recording_institution_id_eq").val(null)

$ ->
  # 入力画面でリセットボタン押下時
  $("#settlements_select_reset").on 'click', ->
    $("input[type='text']").val(0)
