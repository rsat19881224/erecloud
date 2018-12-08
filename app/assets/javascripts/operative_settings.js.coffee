prefix = '#operative_setting_'
TAB_KIND = {COMPANY_INFORMATION: 0, OPERATIVE_SETTING: 1}
formatPostalCode = erecloud_require('formatPostalCode')
checkPostalCode  = erecloud_require('checkPostalCode')

###*
 * 編集前の運用設定をJSON形式で取得する。
 * @return {json} 編集前の運用設定をJSON形式で返す
###
getPreviousOperativeSettingJSON = ->
  data = $('#previous_operative_setting_data').data('previous-data')
  jsonText = data.replace(///=>///g, ':').replace(///nil///g, '""')
  $.parseJSON(jsonText)

###*
 * キャンセルボタン押下時に選択していたタブの変更内容を取り消す
 * @param {integer} tabKind - TAB_KINDでリストされた数値を指定する
###
cancelChange = (tabKind) ->
  previousOperativeSetting = getPreviousOperativeSettingJSON()
  companyInformationSuffixes =
    [
      'company_name1',
      'company_name2',
      'postal_code',
      'address1',
      'address2',
      'company_number',
      'representative_name',
      'representative_official_title',
      'person_in_charge_name',
      'person_in_charge_official_title'
    ]

  switch tabKind
    # 会社情報タブの変更の取り消し
    when TAB_KIND['COMPANY_INFORMATION']
      for suffix in companyInformationSuffixes
        $("#{prefix}#{suffix}").val previousOperativeSetting[suffix]

    # 運用設定タブの変更の取り消し
    when TAB_KIND['OPERATIVE_SETTING']
      # 暦表示形式
      isJapanese = previousOperativeSetting.date_display_format is 'japanese'
      isAnnoDomini = !isJapanese
      $("#{prefix}date_display_format_japanese").iCheck(if isJapanese then 'check' else 'uncheck')
      $("#{prefix}date_display_format_anno_domini").iCheck(if isAnnoDomini then 'check' else 'uncheck')
      # 期日振替
      isTransfer = previousOperativeSetting.is_transfer_fixed_date
      $("#{prefix}is_transfer_fixed_date_true").iCheck(if isTransfer then 'check' else 'uncheck')
      $("#{prefix}is_transfer_fixed_date_false").iCheck(if !isTransfer then 'check' else 'uncheck')
      # 部門権限
      isUseSectionAuthority = previousOperativeSetting.is_use_section_authority
      $("#{prefix}is_use_section_authority_true").iCheck(if isUseSectionAuthority then 'check' else 'uncheck')
      $("#{prefix}is_use_section_authority_false").iCheck(if !isUseSectionAuthority then 'check' else 'uncheck')

###*
 * 参照モードから編集モードへ切り替える
###
changeEditMode = ->
  # 参照フォームを非表示にする
  $('#show_company_information_tab').addClass('hidden')
  $('#show_operative_setting_tab').addClass('hidden')
  # 編集フォームを表示する
  $('#edit_company_information_tab').removeClass('hidden')
  $('#edit_operative_setting_tab').removeClass('hidden')
  # 更新ボタン、キャンセルボタンを有効にする
  $('#operative_setting_cancel').removeClass('disabled')
  $('#operative_setting_submit').removeClass('disabled')
  # small_titleを編集に変更
  smallTitle = $('#edit_small_content_title').data('small-title')
  $('section.content-header').find('small').html(smallTitle)

setupPostalCodeForm = ->
  $("#{prefix}postal_code").on(
    {
      'blur': ->
        code = formatPostalCode($(@).val())
        $(@).val(code)

        unless checkPostalCode($(@).val())
          $(@).addClass('error-form')

      'keyup': ->
        code = $(@).val()
        $(@).val(formatPostalCode(code))

      'paste': ->
        code = $(@).val()
        $(@).val(formatPostalCode(code))
    }
  )

setupCompanyNumberForm = ->
  $("#{prefix}company_number").on('keyup paste', ->
    code = $(@).val()
    $(@).val(code.replace(/[^0-9]+/ig, ''))
  )

$ ->
  # タブの表示
  for id in ['#company_information_tab', '#operative_setting_tab']
    $(id).on 'click', (e) ->
      e.preventDefault()
      $(@).tab('show')

  # キャンセルボタン押下時の処理
  $('#operative_setting_cancel').on 'click', (e) ->
    tabKind = TAB_KIND[(
      if $('#company_information_tab').hasClass('active') then 'COMPANY_INFORMATION' else 'OPERATIVE_SETTING'
    )]
    cancelChange(tabKind)

  # 編集ボタン押下時の処理
  $('#change_edit_mode_button').on 'click', (e) -> changeEditMode()

  setupPostalCodeForm()
  setupCompanyNumberForm()

  #.error-formを持つフォームが一つでもあればsubmitをキャンセル
  $('.operative_setting_form').on 'submit', ->
    errorForms = $(@).find('input.error-form')
    if errorForms.length is 0
      return true
    else
      $(errorForms[0])
        .focus()
        .select()
      .end()
      return false

  # 期日サイト既定値フォームのセットアップ
  setupDefaultPayableSite = erecloud_require('setupDefaultPayableSite')
  setupDefaultPayableSite()
