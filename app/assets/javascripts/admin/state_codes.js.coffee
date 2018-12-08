if gon?
  if gon.editing? and gon.state_code_division?
    $ ->
      $("#state_code_division_#{gon.state_code_division}").attr('checked', true)    
