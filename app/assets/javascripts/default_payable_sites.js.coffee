initializeDefaultPayableSiteForm = ->
  cleanForm = ->
    $("#default_payable_site_#{col}").val('') for col in  ['day', 'month', 'after_day']
    $("#default_payable_site_site_designation_method_no_designation").iCheck('check')

  $('#default_payable_site_contract_credit_category'). on 'change', ->
    $.ajax
      url: '/default_payable_sites'
      type: 'GET'
      data: {selected_contract_credit_category: $('#default_payable_site_contract_credit_category').val()}
      dataType: 'script'
      change: false
    .done (data) ->
      cleanForm()
    .fail (data) ->
      alert '期日サイト既定値の取得に失敗しました。'

  $("#default_payable_site_day").on 'change', ->
    day = parseInt($(@).val())
    if day < 1
      day = 1
    else if (day > 31) and (day isnt 99)
      day = 31
    $(@).val(day)

  $('#default_payable_site_contract_credit_category').val('all')
  cleanForm()

setupDefaultPayableSite = ->
  $('#default_payable_sites_button').on 'click', ->
    $.ajax
      url: '/default_payable_sites'
      type: 'GET'
      dataType: 'html'
    .done (data) ->
      $('.right-side .content').append(data)
      initializeDefaultPayableSiteForm()
      $('#default_payable_sites_modal_form').modal('show')
    .fail (data) ->
      alert '期日サイト既定値登録画面の取得に失敗しました。'

erecloud_export('initializeDefaultPayableSiteForm', initializeDefaultPayableSiteForm)
erecloud_export('setupDefaultPayableSite', setupDefaultPayableSite)
