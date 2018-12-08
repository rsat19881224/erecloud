if gon? and gon.controller_name is 'admin/memus'
  $ ->
    if gon.action_name is 'edit'
      $("#menu_extend_type_#{gon.extend_type}").attr('checked', true)
      $("#menu_approval_setting_used_#{gon.approval_setting_used}").attr('checked', true)
