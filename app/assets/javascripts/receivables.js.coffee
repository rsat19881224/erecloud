$ ->
  setupFinancialInstitutionSearch =
    erecloud_require_module('search_modal').setupFinancialInstitutionSearch
  setupFinancialInstitutionSearch('#receivable_trader_attributes_','search_branch', 'search_bank', 'trader')
  setupFinancialInstitutionSearch('#receivable_opt_trader_attributes_', 'search_branch', 'search_bank', 'opt_trader')
  req =
    erecloud_require_module('recording_institution')

  # サーバーから吐き出された保証人情報に銀行コード補完を付与する
  $('#hosyo .fields .hide').each( ->
    num = $(@).text()
    setupFinancialInstitutionSearch("#receivable_guarantors_attributes_#{num}_", "search_branch", 'search_bank', "guarantors_attributes_#{num}")
    $.when(
      $.ajax({
        url: '/receivables/make_modal'
        dataType: 'script'
        data: {index: num}}))
    .done(->(
        setupFinancialInstitutionSearch("#receivable_guarantors_attributes_#{num}_", "search_branch", 'search_bank', "guarantors_attributes_#{num}"))))

  issueMoneyMirror = ->
    kingaku = $("#receivable_issue_money").val();
    $("#receivable_residual_money").val(kingaku);
    $('.issue_money_mirror').text(kingaku)

  issueMoneyMirror()

  
  # thisにはdepartmentmoneyが入っている
  # 親のfieldsとその兄弟ノードで消されていない物を探して
  # そのdepartment_moneyを足す
  sumBumonMoney = ->
    sumMoney = $(@)
    .closest('.fields')
    .siblings()
    .andSelf()
    .toArray()
    .filter (i) ->
      $(i).find("input[id$=_destroy]").val() is "false"
    .reduce((sum, i) ->
        sum + Number($(i).find('.department_money').val().replace(/[,]/, ''))
    , 0)
    .toString()
    .replace( /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,')
    $('#bumon_issue_money').text(sumMoney)
    
  # 部門内訳の金額が変化するごとに、合計金額を計算する
  addSumBumonMoneyEvent = (jqObj) ->
    jqObj.on('change', sumBumonMoney)

  #今表示されているdepartment_moneyにイベントを付与する
  addSumBumonMoneyEvent($('#bumontable .department_money'))

  
  # nested_form共通で番号をつける
  $(document).on("nested:fieldAdded", (event) ->
    field = event.field
    number = field.find('.no').text()
    addSumBumonMoneyEvent(field.find('.department_money'))
    j = 1
    field.siblings().each ->
      if $(@).find("input[id$=_destroy]").val() is "false"
        $(@).find('.no').text(j)
        j++
    field.find('.no').text(j))

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
        setupFinancialInstitutionSearch("#receivable_guarantors_attributes_#{number}_", "search_branch", 'search_bank', "guarantors_attributes_#{number}"))))
    
    
  # フィールドを削除した時に番号を振り直す
  # 最初のフィールドを消した場合、次の最初のフィールドのラベルを表示させる
  # 金額フィールドに合計計算イベントを付与する
  $(document).on "nested:fieldRemoved", (event) ->
    field = event.field
    sumBumonMoney.call(field.find('.department_money'))
    j = 1
    field.siblings().each (i) ->
      if $(@).find("input[id$=_destroy]").val() is "false"
        $(@).find('.hide').removeClass('hide') if j is 1
        $(@).find('.no').text(j)
        j++
    field.find('.no').text(j)

  $("#receivable_issue_money").on 'change', issueMoneyMirror

  $('.inputCalendars').setCalendar()

# FIXME: bootstrapのtooltipが有効になったら、positionの記述をbootstrapに合わせる
  $('[data-toggle="tooltip"]').tooltip({
    position: {
      my: 'center bottom', at: 'left top', collision: 'none'
    }
  })

  $('[data-toggle="tooltip"]').on 'change', ->
    $(@).attr("title", $(@).val())

  # 請求先による補完
  $("#receivable_trader_id").on 
    'change': -> 
      return false unless trader = parseInt $("#receivable_trader_id").val()
      $.getJSON(
        "/traders/#{trader}.json"
      ).done( (data) ->
        $.each data, (k,v) -> 
          assigner_list()[k].val v
      )

  
  # メモ利用有無
  $("#opt_remark_select").on "ifToggled", -> 
    $("#opt_remark").collapse('toggle')
  # trader_id利用有無
  $("input[id^=trader_id_use_select_").on "ifChanged", ->
    if $('input[id^=trader_id_use_select_]:checked').val() is "true"
      $('#trader *').prop("disabled", "disabled")
      $('#receivable_trader_id').prop("disabled", false)
    else
      $('#trader *').prop("disabled", false)
      $('#receivable_trader_id').prop("disabled", "disabled")
  # 発生区分による表示の切り替え
  $('input[id^=receivable_accrual_type_]:radio').on 'ifChanged', ->
    if $(@)[0].id is "receivable_accrual_type_3" && $(@)[0].checked  # 譲受時
      $('#trader_label').text("譲渡人情報")   
      $('#opt_trader_select').collapse('show')   
    else
      $('#trader_label').text("債務者情報")   
      $('#opt_trader_select, #opt_trader').collapse('hide')   
      $('#opt_trader_selecter').iCheck('uncheck')
  # 譲受時債権者情報有無
  $("#opt_trader_select").on "ifToggled", -> 
    $("#opt_trader").collapse('toggle')
  

  # 発生区分による債務者、譲渡人の切り替え
  assigner_list = ()->
    list =
      name: $("#receivable_trader_attributes_name")
      kana: $("#receivable_trader_attributes_kana")
      bank_code: $("#receivable_trader_attributes_bank_code")
      bank_name: $("#receivable_trader_attributes_bank_name")
      branch_code: $("#receivable_trader_attributes_branch_code")
      branch_name: $("#receivable_trader_attributes_branch_name")
      account_type: $("receivable_trader_attributes_account_type")
      account_number: $("#receivable_trader_attributes_account_number")
      account_client_code: $("#receivable_trader_attributes_user_number")
    
  # 記録番号変更時
  $("#receivable_recording_number").on 'change', ->
    $(@).val(adjustRecordingNumber($(@).val()))

  # 記録番号ロード時
  $ ->
    $("#receivable_recording_number").val(adjustRecordingNumber($("#receivable_recording_number").val()))

  # 記録番号キー押下（keyup）時
  $("#receivable_recording_number").on 'keyup', (event) ->
    if judgeKeyCode(event.keyCode)
      $(@).val(adjustRecordingNumber($(@).val()))
    return

  # キーコード判定処理
  judgeKeyCode = (code) ->
    flag = false
    # 数字キー
    if code >= 48 and code <= 57
      flag = true
    # アルファベット
    if code >= 65 and code <= 90
      flag = true
    # 数字テンキー
    if code >= 96 and code <= 105
      flag = true
    flag

  # 記録番号整形
  adjustRecordingNumber = (inputString) ->
    if /^[A-Z0-9]{9}\-[A-Z0-9]{6}\-[A-Z0-9]{4}\-[A-Z0-9]{1}$/.test(inputString)
      return inputString
    else
      # 半角英数以外を削除
      inputString = checkCharacters(inputString.toUpperCase())

      # 文字数を判定し"-"付与（20文字以上は削除）
      if inputString.length >= 20
        resultStr = ''
        # 9桁-6桁-4桁-1桁
        resultStr += inputString.substr(0, 9) + '-'
        resultStr += inputString.substr(9, 6) + '-'
        resultStr += inputString.substr(15, 4) + '-'
        resultStr += inputString.substr(19, 1)
        return resultStr
      else if inputString.length >= 16 and inputString.length <= 19
        resultStr = ''
        # 9桁-6桁-?桁
        resultStr += inputString.substr(0, 9) + '-'
        resultStr += inputString.substr(9, 6) + '-'
        resultStr += inputString.substr(15)
        return resultStr
      else if inputString.length >= 10 and inputString.length <= 15
        resultStr = ''
        # 9桁-?桁
        resultStr += inputString.substr(0, 9) + '-'
        resultStr += inputString.substr(9)
        return resultStr
      else
        return inputString

  # 半角英数以外の削除
  checkCharacters = (input_string) ->
    element_data = input_string.split('')
    $.each element_data, (key, val) ->
      if val.match(/^[A-Z0-9]+$/) == null
        element_data[key] = ''
      return
    element_data.join ''

  # 登録実施時の記録番号ハイフン削除
  $("#new_receivable").on 'submit', ->
    removeHyphenStr = $("#receivable_recording_number").val().replace /-/g, ''
    $("#receivable_recording_number").val(removeHyphenStr)
    return

  # 検索画面、集計期間「指定なし」選択時
  $("[id^=period_type_]").on 'change', ->
    id = $(@).attr('id').slice(-1)
    if $(@).val() isnt '1'
      $("#period_#{id}_from").prop('disabled', false)
      $("#period_#{id}_to").prop('disabled', false)
    else
      $("#period_#{id}_from").prop('disabled', true)
      $("#period_#{id}_to").prop('disabled', true)

  # 検索画面キャンセル押下
  $("#receivable_search_search").on 'reset', ->
    $('.icheckbox_minimal').attr('aria-checked',false).removeClass('checked')
    $("#particulars-specified").hide()
    $("#recording-institutions-specified").hide()

  # 検索画面「てん末を指定する」チェックボックス変更
  $('input[name="facts_check"]').on 'ifChanged', ->
    $("#particulars-specified").toggle($(@).prop('checked'))

  # 検索画面「記録機関を指定する」チェックボックス変更
  $('input[name="recording_institutions_check"]').on 'ifChanged', ->
    $("#recording-institutions-specified").toggle($(@).prop('checked'))

  # サイト区分変更時
  $('input').on 'ifChecked', (event) ->
    setPaymentDueDate()
  # 発生日付、サイト区分日付入力時
  $('#receivable_occurred_on, #after_n_months, #m_date, #after_s_days').blur ->
    setPaymentDueDate()

  setPaymentDueDate = ->
    #支払期日をクリアする
    $("#receivable_due_become_on").val('')
    site_division = parseInt($("input[name='receivable[site_division]']:checked").val())

    # サイト区分mヶ月n日
    if site_division is 1
      input_month = $('#after_n_months').val()
      input_date = $('#m_date').val()
      # 発生日付
      occurrence_date = $('#receivable_occurred_on').val()

      if occurrence_date and checkInputMonthDate(input_month, input_date)
        # 発生日付にmヶ月後を加算、n日を設定
        occurrence_date = new Date(occurrence_date)
        occurrence_date.setMonth(occurrence_date.getMonth() + parseInt(input_month))

        out_year = occurrence_date.getFullYear()
        out_month = ("0" + (occurrence_date.getMonth() + 1)).slice(-2)
        # n日に99が設定されていたら末尾
        input_date = parseInt(input_date)
        if input_date is 99
          out_date = ("0" + new Date(out_year, out_month, 0).getDate()).slice(-2)
        else
          occurrence_date.setDate(input_date)
          out_date = ("0" + occurrence_date.getDate()).slice(-2)

        # 日付を支払期日に設定
        $("#receivable_due_become_on").val(out_year + "-" + out_month + "-" + out_date)
    # サイト区分s日
    else if site_division is 2
      input_days = $('#after_s_days').val()
      # 発生日付
      occurrence_date = $('#receivable_occurred_on').val()

      if occurrence_date and checkInputDays(input_days)
        # 発生日付にn日後を加算
        occurrence_date = new Date(occurrence_date)
        occurrence_date.setDate(occurrence_date.getDate() + parseInt(input_days))

        out_year = occurrence_date.getFullYear()
        out_month = ("0" + (occurrence_date.getMonth() + 1)).slice(-2)
        out_date = ("0" + occurrence_date.getDate()).slice(-2)

        # 日付を支払期日に設定
        $("#receivable_due_become_on").val(out_year + "-" + out_month + "-" + out_date)

  # mヶ月n日日付チェック
  checkInputMonthDate = (month, date) ->
    if /\d+\.\d+/.test(month) or /\d+\.\d+/.test(date)
      return false
    month = parseInt(month)
    date = parseInt(date)
    if !isFinite(month) or !isFinite(date)
      return false
    if (month < 0) or (month > 12)
     return false
    if (date isnt 99) and (date < 1 or date > 31)
     return false
    return true

  # s日後日付チェック
  checkInputDays = (days) ->
    if /\d+\.\d+/.test(days)
      return false
    days = parseInt(days)
    if !isFinite(days)
      return false
    if 0 <= days <= 999
     return true
    return false
