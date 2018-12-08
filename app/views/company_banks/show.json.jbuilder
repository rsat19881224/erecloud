json.extract!(
  @company_bank,
  *%i(code name bank_code bank_name bank_kana branch_code branch_name branch_kana branch_name
     account_type account_number account_name_kana limit_discount_money client_code
     densai_user_number jemco_user_number jemco_discount_financial_institution_user_number
     jemoco_is_indicate_present_guarantee mizuho_user_number smbc_user_number
    )
)
