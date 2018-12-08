$('#trader_search_result_table').html('<%= j (render partial: "search_result", locals: {traders: @traders, search_kind: @search_kind}) %>')
