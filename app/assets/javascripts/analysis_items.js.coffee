# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#select_division_no').on 'change', ->
    $.ajax
      url: 'analysis_items'
      type: 'GET'
      data: {selected_division_no: $('#select_division_no').val()}
      dataType: 'script'
    #.done (data) ->
    #  alert '成功'
    #.fail (data) ->
    #  alert '失敗'