traderPrefix = '#trader_'
HalfWidthKana = erecloud_require('HalfWidthKana')
PostalCode = erecloud_require('PostalCode')

bindGetSiteModalForm = ->
  $('[id^=trader_default_payable_site_]').on 'click', ->
    traderId = $(@).attr('id').replace /[^0-9]/g, ''
    $.ajax
      type: 'GET'
      dataType: 'html'
      url: '/default_payable_sites/make_trader_site_modal'
      data: {trader_id: traderId}
    .done (data) ->
      $('#trader_site_modal').html(data)
      unless initializeDefaultPayableSiteForm?
        initializeDefaultPayableSiteForm = erecloud_require('initializeDefaultPayableSiteForm')
      initializeDefaultPayableSiteForm()
      $('#default_payable_sites_modal_form').modal('show')
    .fail (data) ->
      alert '取引先サイト既定値の設定画面の取得に失敗しました。'

$ ->
  # 取引先コードの入力制御
  $('#trader_code').on 'blur keyup paste', ->
    code = $(@).val().replace(/[^0-9a-zA-Z]+/ig, '')
    $(@).val(code)

  # 取引先カナのロストフォーカス時に半角カナの拗音を大文字に変換する
  $('#trader_kana').on 'blur', ->
    kana = new HalfWidthKana($(@).val())
    $(@).val(kana.toZenginFormat())

  # 郵便号番フォームの入力制御
  $('#trader_postal_code').on
    'keyup paste': ->
      code = new PostalCode($(@).val())
      $(@).val(code.formattedCode)

    'blur': ->
      code = new PostalCode($(@).val())
      $(@).val(code.formattedCode)
      $(@).addClass('error-form') if code.code isnt '' and not code.isValid()

  # 電話番号、ファックス番号の入力制御
  $('#trader_tel,#trader_fax').on 'blur keyup paste', ->
    tel = $(@).val().replace(/[^0-9\-]+/gi, '')
    $(@).val(tel)

  # 取引先の新規登録時のキャンセルボタン押下時の処理
  $('#trader_new_cancel').on 'click', ->
    textForms = $('#new_trader').find('input[type="text"]')
    for tf in textForms
      $(tf).val('').removeClass('error-form')

    for type in ['billing', 'payment', 'common']
      $("#trader_reference_type_#{type}").iCheck('uncheck')

    $('#trader_is_make_journalizing_false').iCheck('check')

  $("#trader_search_cancel").on 'click', ->
    $.ajax
      type: 'GET'
      dataType: 'script',
      url: '/traders/search'
    .done ->
      $('#q_code_gteq').val('')
      $('#q_code_lteq').val('')
      $('#q_name1_cont').val('')
      $('#q_kana_cont').val('')
      bindGetSiteModalForm()
    .fail (data) ->
      arelt '取引先一覧の取得に失敗しました。'

  $('#trader_search').on 'submit', (e) ->
    e.preventDefault()
    data =
      q:
        code_gteq: $('#q_code_gteq').val()
        code_lteq: $('#q_code_lteq').val()
        name1_cont: $('#q_name1_cont').val()
        kana_cont: $('#q_kana_cont').val()
      search_kind: location.pathname.split('/').slice(-1)[0]
    $.ajax
      type: 'GET'
      dataType: 'script'
      url: '/traders/search'
      data: data
    .done (data) ->
      bindGetSiteModalForm()
    .fail (data) ->
      alert '取引先の検索に失敗しました。'
    return false

  bindGetSiteModalForm()
