$ ->
  errorColor = '#D8000C'
  $('#import-file-name').val('')
  
  $('#file-selection').on('click', ->
    $('#import_file').click()
  )

  $('#import_file').on('change', ->
    importFileField = $('#import-file-name')
    importFileField.val($('#import_file').val())
    importFileField.attr('placeholder', '')
    importFileField.css('border-color', '#CCC')
  )

  $('#import-btn').on('click', ->
    importFileField = $('#import-file-name')
    if importFileField.val() is ''
      importFileField.attr('placeholder', 'please select import file')
      importFileField.css('border-color', '#D8000C')
    else
      $('#import').click()
  )

