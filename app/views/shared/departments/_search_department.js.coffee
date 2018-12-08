<% unless local_assigns.has_key?(:modalid) %>
  <% modalid = 'search_department_modal_result' %>
<% end %>

$("<%= '#' + modalid %>").html('<%= j(render partial: 'shared/departments/search_result', locals: {modalid: modalid}) %>')
