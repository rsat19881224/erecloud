if gon? and gon.action?
  $ ->
    if gon.action is 'index'
      $('.check_used').each(->
        used = $(this).html()
        $(this).html(if used is 'true' then '○' else '✕'))
