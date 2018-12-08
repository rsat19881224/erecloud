$('#default_payable_site_table').html("<%= j(render partial: '/default_payable_sites/list', locals: {sites: sites}) %>")
<%- if sites.first.setting_type == 1 %>
$('<%= "#trader_default_payable_site_#{sites.first.trader_id}" %>').text('<%= t('general.label.edit') %>')
<% end %>
