prefix = '#trader_initial_representation_of_data_attributes_'

$ ->
  $('#initial_representation_of_data_new_cancel').on 'click', ->
    textForms = $('#initial_representation_of_data_form_table').find('input[type="text"], input[type="number"]')
    for form in textForms
      $(form).val('').removeClass('error-form')

    $("#{prefix}pbill_mailing_division_1").iCheck('check')
    $("#{prefix}pbill_postage_division_0").iCheck('check')

  $("#{prefix}pbill_postage, #{prefix}receipt_postage").on 'burl keyup paste', ->
    postage = $(@).val()
    $(@).val(postage.replace /^[^0-9]+$/)
