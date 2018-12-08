# -*- coding: utf-8 -*-
class ChangeColumnToCompanyBank < ActiveRecord::Migration
  def change
    # 必須項目へのNOT NULL制約の追加
    change_column :company_banks, :company_id       , :integer, null: false
    change_column :company_banks, :code             , :string , null: false
    change_column :company_banks, :name             , :string , null: false
    change_column :company_banks, :bank_code        , :string , null: false
    change_column :company_banks, :bank_name        , :string , null: false
    change_column :company_banks, :bank_kana        , :string , null: false
    change_column :company_banks, :branch_code      , :string , null: false
    change_column :company_banks, :branch_name      , :string , null: false
    change_column :company_banks, :branch_kana      , :string , null: false
    change_column :company_banks, :account_number   , :string , null: false
    change_column :company_banks, :account_name_kana, :string , null: false
   
    # 預金種目を整数で保持するように変更
    change_column :company_banks, :account_type, 'integer USING CAST(account_type AS integer)'
    
    # 割引限度額
    rename_column :company_banks, :line_discount  , :limit_discount_money
    # でんさい利用者番号
    rename_column :company_banks, :user_number    , :densai_user_number
    # 電手お客様番号
    rename_column :company_banks, :jemco_number   , :jemco_user_number
    # 電ペイ利用者番号
    rename_column :company_banks, :mizuho_number  , :mizuho_user_number
    # SMBC電子債権利用者番号
    rename_column :company_banks, :smbc_number    , :smbc_user_number
    # 改行コード
    rename_column :company_banks, :carriage_return, :is_use_lf_code

    # 電手割引金融機関お客様番号、電手譲渡時保証初期表示、電手割引銀行お客様番号、終端コード、
    add_column :company_banks, :jemco_number_of_bank                            , :string
    add_column :company_banks, :jemoco_is_indicate_present_guarantee            , :boolean
    add_column :company_banks, :jemco_discount_financial_institution_user_number, :string
    add_column :company_banks, :is_use_eof_code                                 , :boolean

    # 口座名義で検索することはないため除去、end_of_fileはis_use_eof_codeに改名
    remove_column :company_banks, :end_of_file
    remove_column :company_banks, :account_name
  end
end
