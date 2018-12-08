<% unless local_assigns.has_key?(:modalid) %>
  <% modalid = 'search_branch_modal_result' %>
<% end %>

$("<%= '#' + modalid %>").html("<%= j(render partial: 'shared/branches/search_result') %>")
