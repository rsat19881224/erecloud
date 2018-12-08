# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151002064706) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abridgments", force: true do |t|
    t.integer  "company_id"
    t.string   "code"
    t.string   "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "access_controls", force: true do |t|
    t.integer  "user_id"
    t.integer  "menu_id"
    t.integer  "authoritie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "account_debtor_numbers", force: true do |t|
    t.integer  "company_id"
    t.integer  "type"
    t.integer  "trader_id"
    t.integer  "recording_institution_id"
    t.string   "user_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "accounts", force: true do |t|
    t.integer  "company_id"
    t.string   "code"
    t.string   "name"
    t.string   "kana"
    t.integer  "tax_division_id"
    t.integer  "tax_rate_id"
    t.integer  "tax_display"
    t.integer  "round"
    t.integer  "business_division_id"
    t.integer  "fund_division"
    t.integer  "tax_subject_division"
    t.integer  "trader_shared"
    t.integer  "department_input"
    t.integer  "trader_input_division"
    t.boolean  "analysis1_input"
    t.boolean  "analysis2_input"
    t.boolean  "analysis3_input"
    t.boolean  "analysis4_input"
    t.boolean  "analysis5_input"
    t.boolean  "analysis6_input"
    t.boolean  "analysis7_input"
    t.boolean  "analysis8_input"
    t.boolean  "analysis9_input"
    t.boolean  "analysis10_input"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "accounts_settings", force: true do |t|
    t.integer  "company_id"
    t.boolean  "endorsement_ac_used", default: false
    t.boolean  "discount_ac_used",    default: false
    t.string   "abridgment_method",   default: "line"
    t.boolean  "remarks1_reflected",  default: false
    t.boolean  "remarks2_reflected",  default: false
    t.boolean  "remarks3_reflected",  default: false
    t.string   "payment_type",        default: "no_payment"
    t.boolean  "notice_journal_made", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "administrators", force: true do |t|
    t.string   "name",                   default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "administrator_type"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "administrators", ["email"], name: "index_administrators_on_email", unique: true, using: :btree
  add_index "administrators", ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true, using: :btree

  create_table "analysis_divisions", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "abbreviation"
    t.boolean  "used"
    t.integer  "input_division"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "division_no"
  end

  create_table "analysis_items", force: true do |t|
    t.integer  "company_id"
    t.integer  "analysis_division_id"
    t.string   "name"
    t.string   "abbreviation"
    t.string   "kana"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "analysis_items", ["name"], name: "index_analysis_items_on_name", unique: true, using: :btree

  create_table "approval_settings", force: true do |t|
    t.integer  "company_id"
    t.integer  "menu_id"
    t.string   "approval_type"
    t.boolean  "one_phase_approval_skiped"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "approvers", force: true do |t|
    t.integer  "company_id"
    t.integer  "menu_id"
    t.integer  "user_id"
    t.string   "approver_type"
    t.boolean  "mail_delivered"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "authorities", force: true do |t|
    t.integer  "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "bank_holidays", force: true do |t|
    t.datetime "holiday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "banks", force: true do |t|
    t.string   "code",       null: false
    t.string   "name",       null: false
    t.string   "kana"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "branches", force: true do |t|
    t.integer  "bank_id",    null: false
    t.string   "code",       null: false
    t.string   "name",       null: false
    t.string   "kana"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "business_divisions", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "companies", force: true do |t|
    t.integer  "management_division_id"
    t.string   "number"
    t.boolean  "affiliated"
    t.string   "group_number"
    t.boolean  "demanded"
    t.string   "name"
    t.string   "postal_code"
    t.string   "prefecture"
    t.string   "address"
    t.string   "tel"
    t.string   "fax"
    t.string   "affiliated_post"
    t.string   "charge_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "company_banks", force: true do |t|
    t.integer  "company_id",                                                       null: false
    t.string   "code",                                                             null: false
    t.string   "name",                                                             null: false
    t.string   "bank_code",                                                        null: false
    t.string   "bank_name",                                                        null: false
    t.string   "bank_kana",                                                        null: false
    t.string   "branch_code",                                                      null: false
    t.string   "branch_name",                                                      null: false
    t.string   "branch_kana",                                                      null: false
    t.integer  "account_type"
    t.string   "account_number",                                                   null: false
    t.string   "account_name_kana",                                                null: false
    t.integer  "limit_discount_money"
    t.string   "client_code"
    t.string   "densai_user_number"
    t.string   "jemco_user_number"
    t.string   "mizuho_user_number"
    t.string   "smbc_user_number"
    t.string   "record_length",                                    default: "120"
    t.boolean  "record_type",                                      default: true
    t.boolean  "is_use_lf_code",                                   default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "jemco_number_of_bank"
    t.boolean  "jemoco_is_indicate_present_guarantee"
    t.string   "jemco_discount_financial_institution_user_number"
    t.boolean  "is_use_eof_code"
  end

  add_index "company_banks", ["company_id", "code"], name: "index_company_banks_on_company_id_and_code", unique: true, using: :btree

  create_table "data_substitutions", force: true do |t|
    t.integer  "output_orders_id"
    t.integer  "output_form_id"
    t.string   "output_item"
    t.string   "substituted_previous_value"
    t.string   "substituted_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "date_bank_spreadsheets", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "default_payable_sites", force: true do |t|
    t.integer  "company_id",               null: false
    t.string   "designated_division"
    t.string   "contract_credit_category"
    t.string   "site_designation_method"
    t.integer  "month"
    t.integer  "day"
    t.integer  "after_day"
    t.string   "holiday_transfer_method"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "trader_id"
    t.integer  "setting_type",             null: false
  end

  create_table "departments", force: true do |t|
    t.integer  "company_id"
    t.string   "code"
    t.string   "name"
    t.string   "name_kana"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "ebill_histories", force: true do |t|
    t.integer  "company_id"
    t.string   "process_type"
    t.integer  "menu_id"
    t.string   "computer_name"
    t.integer  "user_id"
    t.datetime "registered_at"
    t.integer  "ebill_id"
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

  create_table "ebill_receivable_states", force: true do |t|
    t.integer  "ebill_id"
    t.integer  "recording_institution_id"
    t.string   "recording_number",           limit: 20
    t.integer  "state_code_id"
    t.integer  "acquisition_division"
    t.integer  "trader_id"
    t.string   "trader_name1"
    t.string   "trader_name2"
    t.string   "trader_kana",                limit: 40
    t.string   "trader_bank_code",           limit: 4
    t.string   "trader_bank_kana",           limit: 15
    t.string   "trader_branch_code",         limit: 3
    t.string   "trader_branch_kana",         limit: 15
    t.integer  "trader_account_type"
    t.string   "trader_account_number",      limit: 7
    t.string   "trader_user_number",         limit: 9
    t.string   "debtor_user_number",         limit: 9
    t.string   "debtor_name",                limit: 50
    t.string   "debtor_kana",                limit: 40
    t.string   "debtor_bank_code",           limit: 4
    t.string   "debtor_bank_kana",           limit: 15
    t.string   "debtor_branch_code",         limit: 3
    t.string   "debtor_branch_kana",         limit: 15
    t.integer  "debtor_account_type"
    t.string   "debtor_account_number",      limit: 7
    t.date     "transferred_on"
    t.date     "occurred_on"
    t.decimal  "issue_money"
    t.decimal  "amount_money"
    t.decimal  "residual_money"
    t.decimal  "number_of_times"
    t.date     "discount_requested_on"
    t.date     "matured_on"
    t.date     "settled_on"
    t.integer  "company_bank_id"
    t.integer  "department_id"
    t.integer  "operating_item_id"
    t.integer  "bmanagement_item_id"
    t.integer  "transferee_guaranteed"
    t.integer  "transfer_restricted"
    t.string   "division_recording_number",  limit: 20
    t.integer  "transferee_trader_id"
    t.string   "transferee_name1"
    t.string   "transferee_name2"
    t.string   "transferee_kana",            limit: 40
    t.string   "transferee_bank_code",       limit: 4
    t.string   "transferee_bank_kana",       limit: 15
    t.string   "transferee_branch_code",     limit: 3
    t.string   "transferee_branch_kana",     limit: 15
    t.integer  "transferee_account_type"
    t.string   "transferee_account_number",  limit: 7
    t.string   "transferee_user_number",     limit: 9
    t.integer  "guaranteed"
    t.decimal  "discount_charge"
    t.decimal  "bank_transfer_fee"
    t.integer  "own_state_id"
    t.integer  "Journal_made"
    t.integer  "discount_guidance_issued"
    t.integer  "payment_guidance_issued"
    t.integer  "return_state"
    t.string   "ref_no",                     limit: 40
    t.string   "remarks1",                   limit: 50
    t.string   "remarks2",                   limit: 50
    t.string   "remarks3",                   limit: 50
    t.integer  "creditor_deleted"
    t.decimal  "recordable_number_of_times"
    t.integer  "approver_type"
    t.integer  "approved"
    t.integer  "output"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "process_type"
    t.integer  "menu_id"
    t.string   "computer_name"
    t.integer  "user_id"
    t.datetime "registered_at"
    t.integer  "ebill_receivable_state_id"
  end

  create_table "ebills", force: true do |t|
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

  create_table "guarantors", force: true do |t|
    t.integer  "ebill_id"
    t.integer  "trader_id"
    t.string   "guarantor_name"
    t.string   "guarantor_kana"
    t.string   "bank_code"
    t.string   "bank_kana"
    t.string   "branch_code"
    t.string   "branch_kana"
    t.integer  "account_type"
    t.string   "account_number"
    t.date     "guaranty_recorded_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "infos", force: true do |t|
    t.string   "type"
    t.string   "title"
    t.string   "content"
    t.date     "display_from"
    t.date     "display_to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "initial_representation_of_data", force: true do |t|
    t.integer  "trader_id",                                         null: false
    t.integer  "pbill_mailing_division",                default: 1
    t.integer  "pbill_postage_division",                default: 0
    t.integer  "pbill_postage"
    t.integer  "receipt_postage"
    t.string   "rbill_drawing_bank_code"
    t.string   "rbill_drawing_bank_name"
    t.string   "rbill_drawing_branch_code"
    t.string   "rbill_drawing_branch_name"
    t.integer  "pbill_company_bank_id"
    t.integer  "ebill_settling_company_bank_id"
    t.integer  "ebill_payment_company_bank_id"
    t.integer  "rfactoring_company_bank_id"
    t.integer  "pfactoring_company_bank_id"
    t.integer  "bank_transfer_receipt_company_bank_id"
    t.integer  "bank_transfer_payment_company_bank_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "journalizing_data_output_settings", force: true do |t|
    t.integer  "company_id"
    t.integer  "output_form_id"
    t.string   "serial_number_method"
    t.string   "last_slip_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "journalizing_making_settings", force: true do |t|
    t.integer  "company_id"
    t.integer  "credit_debt_division"
    t.integer  "state_codes_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "journalizing_output_items", force: true do |t|
    t.integer  "code"
    t.string   "name"
    t.string   "name_for_indication"
    t.integer  "item_division"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "journalizing_slip_settings", force: true do |t|
    t.integer  "company_id"
    t.string   "company_cord_for_accounts"
    t.string   "slip_creator_code"
    t.string   "approver_code"
    t.integer  "is_use_valuation_department"
    t.integer  "is_use_valuation_trader"
    t.integer  "abridgment_method"
    t.integer  "number_of_output_abridgment"
    t.integer  "journalizing_processing_method_ebill"
    t.integer  "journalizing_processing_method_rbill"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "license_allotments", force: true do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.integer  "license_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "licenses", force: true do |t|
    t.integer  "company_id",        null: false
    t.integer  "product_id",        null: false
    t.integer  "number_of_license", null: false
    t.datetime "use_starting_date", null: false
    t.datetime "use_end_date",      null: false
    t.integer  "period_of_service", null: false
    t.string   "license_type",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "management_divisions", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "management_items", force: true do |t|
    t.integer  "company_id"
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "menu_authorities", force: true do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.integer  "menu_id"
    t.string   "authority_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "menus", force: true do |t|
    t.string   "code",                  default: "",    null: false
    t.string   "name",                  default: "",    null: false
    t.string   "product_category"
    t.string   "manager_division"
    t.boolean  "approval_setting_used", default: false, null: false
    t.string   "extend_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "menus", ["code"], name: "index_menus_on_code", unique: true, using: :btree

  create_table "operating_division_settings", force: true do |t|
    t.integer  "company_id"
    t.integer  "operating_division_id"
    t.string   "input_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "operating_divisions", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "abbreviation"
    t.boolean  "used"
    t.integer  "input_division"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "division_no"
  end

  add_index "operating_divisions", ["name"], name: "index_operating_divisions_on_name", unique: true, using: :btree

  create_table "operating_items", force: true do |t|
    t.integer  "company_id"
    t.integer  "operating_division_id"
    t.string   "name"
    t.string   "abbreviation"
    t.string   "kana"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "operative_settings", force: true do |t|
    t.integer  "company_id",                      default: 0,     null: false
    t.string   "company_name1",                                   null: false
    t.string   "company_name2"
    t.string   "postal_code"
    t.string   "address1"
    t.string   "address2"
    t.string   "representative_official_title"
    t.string   "representative_name"
    t.string   "company_number"
    t.string   "person_in_charge_official_title"
    t.string   "person_in_charge_name"
    t.string   "date_display_format"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.boolean  "is_transfer_fixed_date",          default: true,  null: false
    t.boolean  "is_use_section_authority",        default: false, null: false
  end

  create_table "output_forms", force: true do |t|
    t.integer  "pattern_division"
    t.integer  "company_id"
    t.integer  "delimiter"
    t.integer  "character_code"
    t.integer  "number_of_slip_number_figures"
    t.integer  "attached_0_befor"
    t.string   "date_output_Format"
    t.string   "filename_extension"
    t.string   "extension"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "output_orders", force: true do |t|
    t.integer  "output_form_id"
    t.integer  "journalizing_output_item_id"
    t.integer  "item_attribution"
    t.integer  "addition_rule"
    t.integer  "addition_state"
    t.string   "fixed_value_data"
    t.string   "output_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "own_states", force: true do |t|
    t.integer  "company_id"
    t.string   "code"
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "products", force: true do |t|
    t.string   "code",                    default: "",    null: false
    t.string   "name",                    default: "",    null: false
    t.boolean  "bill_credit_used",        default: false, null: false
    t.boolean  "bill_debit_used",         default: false, null: false
    t.boolean  "ebill_credit_used",       default: false, null: false
    t.boolean  "ebill_debit_used",        default: false, null: false
    t.boolean  "factoring_credit_used",   default: false, null: false
    t.boolean  "factoring_debit_used",    default: false, null: false
    t.boolean  "account_receivable_used", default: false, null: false
    t.boolean  "account_payable_used",    default: false, null: false
    t.boolean  "print_option_used",       default: false, null: false
    t.boolean  "extended",                default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "products", ["code"], name: "index_products_on_code", unique: true, using: :btree

  create_table "receipts", force: true do |t|
    t.integer  "company_id"
    t.string   "auto_number"
    t.string   "receipt_number"
    t.integer  "trader_id"
    t.string   "corporation_number"
    t.string   "trader_name1"
    t.string   "trader_name2"
    t.date     "received_on"
    t.date     "printed_on"
    t.string   "total_amount"
    t.string   "tax_8"
    t.string   "tax_10"
    t.string   "tax1"
    t.string   "tax2"
    t.string   "taxable_amount"
    t.string   "stamp_duty"
    t.string   "detail_cash"
    t.string   "check"
    t.string   "bank_transfer"
    t.string   "bill"
    t.string   "bill_count"
    t.string   "offset"
    t.string   "detail_others1"
    t.string   "detail_others2"
    t.string   "provision"
    t.string   "remarks"
    t.string   "divided"
    t.integer  "receipt_id"
    t.string   "partingl_number"
    t.string   "bill_made"
    t.boolean  "receipt_issued"
    t.boolean  "reissued"
    t.date     "reissued_on"
    t.integer  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "recording_institutions", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "abbreviation"
    t.string   "recording_number_digit"
    t.string   "user_number_digit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "remarks", force: true do |t|
    t.integer  "company_id"
    t.string   "code"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "section_breakdowns", force: true do |t|
    t.integer  "bill_id"
    t.integer  "company_id"
    t.integer  "input_type"
    t.integer  "department_id"
    t.integer  "department_money"
    t.integer  "management_item_id"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "security_policies", force: true do |t|
    t.integer  "company_id"
    t.string   "min_characters"
    t.boolean  "included_three_kinds"
    t.boolean  "included_account"
    t.string   "number_of_history_generations"
    t.string   "valid_period"
    t.string   "change_prohibition_period"
    t.string   "lockout_setting"
    t.string   "time_elapsed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "slip_details", force: true do |t|
    t.integer  "slip_header_id"
    t.string   "line_number"
    t.string   "balanced"
    t.string   "department_code"
    t.string   "department_name"
    t.string   "account_code"
    t.string   "account_name"
    t.string   "sub_account_code"
    t.string   "sub_account_name"
    t.string   "including_tax"
    t.integer  "excluding_taxes"
    t.integer  "consumption_tax"
    t.string   "tax_division_code"
    t.string   "tax_division_name"
    t.integer  "tax_rate"
    t.string   "business_division_code"
    t.string   "analysis_account1_code"
    t.string   "analysis_account2_code"
    t.string   "analysis_account3_code"
    t.string   "analysis_account4_code"
    t.string   "analysis_account5_code"
    t.string   "analysis_account6_code"
    t.string   "analysis_account7_code"
    t.string   "analysis_account8_code"
    t.string   "analysis_account9_code"
    t.string   "analysis_account10_code"
    t.string   "trader_code"
    t.string   "abridgment"
    t.integer  "details_linage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "tax_display"
    t.integer  "round"
  end

  create_table "slip_divisions", force: true do |t|
    t.integer  "company_id"
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "slip_headers", force: true do |t|
    t.integer  "bill_id"
    t.integer  "bill_state_history_id"
    t.string   "slip_number"
    t.string   "slip_division_code"
    t.string   "operating_division1_code"
    t.string   "operating_division2_code"
    t.string   "operating_division3_code"
    t.string   "operating_division4_code"
    t.string   "operating_division5_code"
    t.integer  "user_id"
    t.integer  "renew_user_id"
    t.string   "approved"
    t.boolean  "exported"
    t.datetime "journalizing_slip_date"
    t.integer  "details_linage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "stamp_taxes", force: true do |t|
    t.string   "tax_type"
    t.integer  "tax"
    t.integer  "above_Par"
    t.integer  "below_Par"
    t.date     "enforced_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "state_codes", force: true do |t|
    t.integer  "code"
    t.integer  "division"
    t.string   "bill"
    t.string   "ebill"
    t.string   "factoring"
    t.string   "cash_payment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "sub_accounts", force: true do |t|
    t.integer  "account_id"
    t.string   "code"
    t.string   "name"
    t.string   "kana"
    t.integer  "tax_division_id"
    t.integer  "tax_rate_id"
    t.integer  "tax_display"
    t.integer  "round"
    t.integer  "business_division_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "summary_details_settings", force: true do |t|
    t.integer  "company_id"
    t.integer  "rbill_summary_making"
    t.integer  "pbill_summary_making"
    t.integer  "ebill_receivable_summary_making"
    t.integer  "ebill_summary_making"
    t.integer  "factoring_credit_summary_making"
    t.integer  "factoring_debt_summary_making"
    t.integer  "date_receipt_summary_making"
    t.integer  "date_payment_summary_making"
    t.integer  "added_to_due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "tax_divisions", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "indication_name"
    t.string   "taxed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "tax_rates", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "rate"
    t.date     "executed_on"
    t.boolean  "used"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "template_details", force: true do |t|
    t.integer  "template_header_id"
    t.integer  "line_number"
    t.string   "balanced"
    t.integer  "department_id"
    t.integer  "account_id"
    t.integer  "sub_account_id"
    t.integer  "analysis_account1_id"
    t.integer  "analysis_account2_id"
    t.integer  "analysis_account3_id"
    t.integer  "analysis_account4_id"
    t.integer  "analysis_account5_id"
    t.integer  "analysis_account6_id"
    t.integer  "analysis_account7_id"
    t.integer  "analysis_account8_id"
    t.integer  "analysis_account9_id"
    t.integer  "analysis_account10_id"
    t.string   "abridgment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "template_headers", force: true do |t|
    t.integer  "company_id"
    t.string   "setting_type"
    t.string   "item"
    t.string   "division"
    t.integer  "management_item_id"
    t.integer  "company_bank_id"
    t.integer  "trader_id"
    t.integer  "state_code_id"
    t.integer  "own_state_id"
    t.integer  "slip_division_id"
    t.integer  "operating_division1_id"
    t.integer  "operating_division2_id"
    t.integer  "operating_division3_id"
    t.integer  "operating_division4_id"
    t.integer  "operating_division5_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "trader_bank_accounts", force: true do |t|
    t.integer  "trader_id",                            null: false
    t.string   "bank_code"
    t.string   "bank_name"
    t.string   "bank_kana"
    t.string   "branch_code"
    t.string   "branch_name"
    t.string   "branch_kana"
    t.integer  "account_type"
    t.string   "account_number"
    t.string   "account_name_kana"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "edi_code1"
    t.string   "edi_code2"
    t.string   "densai_user_number"
    t.boolean  "densai_is_priority",   default: false
    t.string   "jemco_user_number"
    t.string   "jemco_payment_number"
    t.boolean  "jemco_is_priority",    default: false
  end

  create_table "traders", force: true do |t|
    t.integer  "company_id",                                      null: false
    t.string   "code"
    t.string   "corporation_number"
    t.string   "name1"
    t.string   "name2"
    t.string   "kana"
    t.string   "short_name"
    t.string   "postal_code"
    t.string   "address1"
    t.string   "address2"
    t.string   "person_in_charge_official_title"
    t.string   "person_in_charge_name"
    t.string   "tel"
    t.string   "fax"
    t.string   "email"
    t.string   "reference_type"
    t.string   "customer_code"
    t.string   "vendor_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "corporation_name"
    t.boolean  "is_make_journalizing",            default: false
  end

  add_index "traders", ["code"], name: "index_traders_on_code", unique: true, using: :btree
  add_index "traders", ["company_id", "code"], name: "index_traders_on_company_id_and_code", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.integer  "company_id"
    t.string   "code",                             default: "",     null: false
    t.string   "name",                             default: "",     null: false
    t.string   "password",                         default: "",     null: false
    t.string   "encrypted_password",               default: "",     null: false
    t.string   "email",                            default: "",     null: false
    t.string   "contact_mail"
    t.string   "user_type",                        default: "user", null: false
    t.boolean  "password_unlimited",               default: false,  null: false
    t.boolean  "next_login_time_password_changed", default: false,  null: false
    t.boolean  "locked",                           default: false,  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "lockout_time"
    t.datetime "deleted_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
