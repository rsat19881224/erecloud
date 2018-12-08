class ChangeColumnToTraderBankAccounts < ActiveRecord::Migration
  def change
    change_column :trader_bank_accounts, :trader_id, :integer, null: false
    change_column :trader_bank_accounts, :account_type, 'integer USING CAST("account_type" AS integer)'

    add_column :trader_bank_accounts, :edi_code1, :string
    add_column :trader_bank_accounts, :edi_code2, :string
    add_column :trader_bank_accounts, :densai_user_number, :string
    add_column :trader_bank_accounts, :densai_is_priority, :boolean, default: false
    add_column :trader_bank_accounts, :jemco_user_number, :string
    add_column :trader_bank_accounts, :jemco_payment_number, :string
    add_column :trader_bank_accounts, :jemco_is_priority, :boolean, default: false

    remove_column :trader_bank_accounts, :account_name
    remove_column :trader_bank_accounts, :client_code1
    remove_column :trader_bank_accounts, :client_code2
    remove_column :trader_bank_accounts, :ebill_user_number
    remove_column :trader_bank_accounts, :jemco_creditor_code
    remove_column :trader_bank_accounts, :jemco_client_number
  end
end
