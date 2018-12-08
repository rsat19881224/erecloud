# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # ▼てん末処理・移動先を指定す初期表示
  $("#transferee_state").hide()
  # ▼てん末処理・移動先を指定するの表示切り替え
  $("#transferee_state_title").on 'click', ->
    $("#transferee_state").toggle(200);
