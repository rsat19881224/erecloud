setupSearch = (modelName, targetFormIds, keyCodes, searchHandler, setHandler, modalid) ->
  $ ->
    if modalid?
      modalFormId   = "#search_#{modelName}_#{modalid}_modal_form"
      modalResultId = "#search_#{modelName}_#{modalid}_modal_result"
    else
      modalFormId   = "#search_#{modelName}_modal_form"
      modalResultId = "#search_#{modelName}_modal_result"

    showSearchModal = (e) ->
      if _.contains(keyCodes, e.keyCode)
        searchHandler() if searchHandler?
        
        $(modalFormId).on 'shown.bs.modal', ->
          $(modalFormId).trigger('initialize', e.currentTarget.id)
        
        $(modalFormId).modal('show')
        
    $(id).keydown(showSearchModal) for id in targetFormIds

    $(modalFormId).on 'initialize', (event, textFieldId) ->
      if (targetFormIds.some (i) -> ~i.match(///#{textFieldId}///)?)
        $(document).on 'click', "#{modalResultId} tr button", ->
          row  = $(this).closest('tr').index()          
          tr   = $("#{modalResultId} table tbody tr:eq(#{row})")[0]
          id   = tr.id.match(RegExp("#{modelName}_[0-9]+"))
          data = $.parseJSON($("#{modalResultId}_#{id}_json").text().replace(/\=\>/g, ':'))
          setHandler(data)
          $(modalFormId).modal('hide')

setupFinancialInstitutionSearch = (prefix, searchBankUrl, searchBranchUrl, modalid = null) ->
  suffixes = ['_code', '_name', '_kana']
  branch_search_result_id = if modalid? then "search_branch_#{modalid}_modal_result" else "search_branch_modal_result"
  
  bankSearchAllowFormIds = ("#{prefix}bank#{suffix}" for suffix in suffixes)
  [bankCodeId, bankNameId, bankKanaId] = bankSearchAllowFormIds
  bankSearchHandler = ->
    $.when(
      $.ajax
        url: searchBankUrl
        type: 'GET'
        dataType: 'script'
        data:
          {
            selected_bank:
              {
                code_eq: $(bankCodeId).val()
                name_cont: $(bankNameId).val()
                kana_cont: $(bankKanaId).val()
              }
          }
    ).fail((data)->
      alert '銀行検索フォームの表示に失敗しました。'
    )

  setSearchBankHandler = (bank) ->
    $(bankCodeId).val bank.code
    $(bankNameId).val bank.name
    $(bankKanaId).val bank.kana

  branchSearchAllowFormIds = ("#{prefix}branch#{suffix}" for suffix in suffixes)
  [branchCodeId, branchNameId, branchKanaId] =  branchSearchAllowFormIds
  branchSearchHandler = ->
    $.when(
      $.ajax
        url: searchBranchUrl
        type: 'GET'
        dataType: 'script'
        data:
          {
            selected_bank:
              {
                code_eq: $(bankCodeId).val()
                name_cont: $(bankNameId).val()
                kana_cont: $(bankKanaId).val()
                modalid: branch_search_result_id
              }
            selected_branch:
              {
                code_eq: $(branchCodeId).val()
                name_cont: $(branchNameId).val()
                kana_cont: $(branchKanaId).val()
              }
          }
    ).fail((data)->
      alert '支店検索フォームの表示に失敗しました。'
    )

  setSearchBranchHandler = (branch) ->
    $(branchCodeId).val branch.code
    $(branchNameId).val branch.name
    $(branchKanaId).val branch.kana

  $('#branch_search').on('submit', (->
    bank_info =
      {
        code_eq:   $(bankCodeId).val()
        name_cont: $(bankNameId).val()
        kana_cont: $(bankKanaId).val()
        modalid: branch_search_result_id
      }

    for k, v of bank_info
      $('<input />').attr('type', 'hidden')
      .attr('name', "selected_bank[#{k}]")
      .attr('value', v)
      .appendTo(@)

    return true
  ))

  setupSearch('bank'  , bankSearchAllowFormIds  , [32], bankSearchHandler  , setSearchBankHandler  , modalid)
  setupSearch('branch', branchSearchAllowFormIds, [32], branchSearchHandler, setSearchBranchHandler, modalid)

setupDepartmentSearch = (prefix, searchDepartmentUrl, modalid = null) ->
  codeId         = "#{prefix}code"
  nameId         = "#{prefix}name"
  kanaId         = "#{prefix}name_kana"
  abbreviationId = "#{prefix}abbreviation"
  targetFormIds  = [codeId, nameId]
  department_modalid = if modalid? then "search_department_#{modalid}_modal_result" else 'search_department_modal_result'
  
  departmentSearchHandler = ->
    $.when(
      $.ajax
        url: searchDepartmentUrl
        type: 'GET'
        dataType: 'script'
        data:
          {
            selected_department:
              {
                code_eq: $(codeId).val(),
                name_cont: $(nameId).val(),
                modalid: department_modalid
              }
          }
    ).fail((data)->
      alert '部門検索フォームの表示に失敗しました。'
    )

  departmentSetHandler = (department) ->
    $(codeId).val(department.code)
    $(nameId).val(department.name)
    $(kanaId).val(department.name_kana)
    $(abbreviationId).val(department.abbreviation)

  setupSearch('department', targetFormIds, [32], departmentSearchHandler, departmentSetHandler)

erecloud_export_module('search_modal', 'setupSearch', setupSearch)
erecloud_export_module('search_modal', 'setupFinancialInstitutionSearch', setupFinancialInstitutionSearch)
erecloud_export_module('search_modal', 'setupDepartmentSearch', setupDepartmentSearch)
