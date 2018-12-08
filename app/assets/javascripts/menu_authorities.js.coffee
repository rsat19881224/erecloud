if gon? and gon.controller_name is "menu_authorities" and  gon.action_name is "new"
  $ ->
    $(document).ready(user_change_ajax_handler)
    $("select#menu_authority_user_id").change(user_change_ajax_handler)

user_change_ajax_handler = ->
  $.ajax({
    type: "GET",
    url: "/menu_authorities/menu_option_collections",
    data: {selected_user_id: $("select#menu_authority_user_id option:selected").attr("value")},
    dataType: "html",
    success: (data) -> $("select#menu_authority_menu_id").html(data)
  })
