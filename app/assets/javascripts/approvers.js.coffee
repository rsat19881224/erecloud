if gon? and gon.controller_name is "approvers" and _.include(["new", "edit"], gon.action_name)
  $ ->
    $(document).ready(approver_user_change_ajax_handler)
    $("select#approver_user_id").change(approver_user_change_ajax_handler)
    
approver_user_change_ajax_handler = ->
  $.ajax({
    type: "GET",
    url: "/approvers/menu_collection",
    data: {selected_user_id: $(":selected").attr("value")},
    dataType: "html",
    success: (data) ->
               console.log(data)
               $("#menu_select_form").html(data)
    error: (data) -> console.log(data)
  })
