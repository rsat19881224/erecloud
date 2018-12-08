$('#default_payable_site_table').html("<%= j(render partial: '/default_payable_sites/list', locals: {sites: sites}) %>")
