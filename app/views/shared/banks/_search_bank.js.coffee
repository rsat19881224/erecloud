<% unless local_assigns.has_key?(:modalid) %>
  <% modalid = 'search_bank_modal_result' %>
<% end %>

$("<%= '#' + modalid %>").html("<%= j(render partial: 'shared/banks/search_result', locals: {modalid: modalid}) %>")
