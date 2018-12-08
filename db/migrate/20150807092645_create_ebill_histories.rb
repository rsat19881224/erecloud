class CreateEbillHistories < ActiveRecord::Migration
  def change
    create_table :ebill_histories do |t|
      t.integer  "company_id"
      t.string   "process_type"
      t.integer  "menu_id"
      t.string   "computer_name"
      t.integer  "user_id"
      t.datetime "registered_at"
      t.integer  "ebill_id"
      t.integer  "company_id"
      t.integer  "counterparty_company_id"
      t.integer  "data_type"
      t.integer  "settlement_type"
      t.integer  "factor_id"
      t.string   "control_number"
      t.integer  "recording_institution_id"
      t.string   "recording_number"
      t.integer  "accrual_type"
      t.boolean  "transferred"
      t.date     "occurred_on"
      t.date     "due_become_on"
      t.integer  "issue_money"
      t.boolean  "transfer_restricted"
      t.string   "ref_no"
      t.string   "debtor_user_number"
      t.string   "creditor_user_number"
      t.integer  "trader_id"
      t.string   "creditor_name"
      t.string   "creditor_bank_code"
      t.string   "creditor_bank_kana"
      t.string   "creditor_branch_code"
      t.string   "creditor_branch_kana"
      t.integer  "creditor_account_type"
      t.string   "creditor_account_number"
      t.integer  "debtors_company_bank_id"
      t.integer  "debtors_department_id"
      t.boolean  "drawing_Journal_made"
      t.string   "assignor_bank_code"
      t.string   "assignor_bank_kana"
      t.string   "assignor_branch_code"
      t.string   "assignor_branch_kana"
      t.integer  "assignor_account_type"
      t.string   "assignor_account_number"
      t.string   "debtor_bank_code"
      t.string   "debtor_bank_kana"
      t.string   "debtor_branch_code"
      t.string   "debtor_branch_kana"
      t.integer  "debtor_account_type"
      t.string   "debtor_account_number"
      t.integer  "approver_type"
      t.boolean  "approved"
      t.integer  "payment_guidance_issued"
      t.date     "settled_on"
      t.boolean  "settlement_Journal_made"
      t.integer  "debt_state_division"
      t.integer  "insolvency_presence"
      t.date     "returned_on"
      t.string   "return_remarks"
      t.boolean  "debtor_deleted"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "deleted_at"
      t.integer  "company_division"
      t.date     "last_transferred_on"
      t.decimal  "recordable_number_of_times",              precision: 8, scale: 0
      t.string   "creditor_name1"
      t.string   "creditor_name2"
      t.integer  "state_code_id"
      t.integer  "operating_item_id"
      t.integer  "management_item_id"
      t.string   "debtors_remarks1",             limit: 50
      t.string   "debtors_remarks2",             limit: 50
      t.string   "debtors_remarks3",             limit: 50
      t.integer  "output"
      t.integer  "debtor_trader_id"
      t.string   "debtor_name",                  limit: 50
      t.string   "debtor_kana",                  limit: 40
      t.string   "assignor_number",              limit: 9
      t.string   "assignor_kana",                limit: 40
      t.string   "last_creditor_user_number",    limit: 9
      t.string   "last_creditor_kana",           limit: 40
      t.string   "last_creditor_bank_code",      limit: 4
      t.string   "last_creditor_bank_kana",      limit: 15
      t.string   "last_creditor_branch_code",    limit: 3
      t.string   "last_creditor_branch_kana",    limit: 15
      t.integer  "last_creditor_account_type"
      t.string   "last_creditor_account_number", limit: 7
      t.integer  "registration_division"
    end
  end
end
