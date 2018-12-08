# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#select_account_id').on 'change', ->
    $.ajax
      url: 'sub_accounts'
      type: 'GET'
      data: {selected_account_id: $('#select_account_id').val()}
      dataType: 'script'