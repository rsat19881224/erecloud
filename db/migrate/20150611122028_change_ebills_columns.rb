class ChangeEbillsColumns < ActiveRecord::Migration
  def change
    remove_column :ebills, :company_type, :integer
    remove_column :ebills, :occurrence_type, :integer
    remove_column :ebills, :creditor_type, :integer
    remove_column :ebills, :debtors_remarks, :string
    remove_column :ebills, :transferor_user_number, :string
    remove_column :ebills, :assignor_name, :string
    remove_column :ebills, :debtor_trader_name, :string
    remove_column :ebills, :residual_money, :integer
    remove_column :ebills, :up_load_made, :boolean
    remove_column :ebills, :payment_data_made, :boolean
    remove_column :ebills, :return_state, :integer
    remove_column :ebills, :record_type, :integer
    remove_column :ebills, :record_settled, :integer
    remove_column :ebills, :created_user_id, :integer
    remove_column :ebills, :update_user_id, :integer
    remove_column :ebills, :type, :string

    # 新規追加
    add_column :ebills, :company_division, :integer, limit:3
    add_column :ebills, :last_transferred_on,  :date
    add_column :ebills, :recordable_number_of_times,  :decimal, precision: 8
    add_column :ebills, :creditor_name1, :string
    add_column :ebills, :creditor_name2, :string
    add_column :ebills, :state_code_id,  :integer, limit:3
    add_column :ebills, :operating_item_id,  :integer
    add_column :ebills, :management_item_id, :integer
    add_column :ebills, :debtors_remarks1, :string, limit: 50
    add_column :ebills, :debtors_remarks2, :string, limit: 50
    add_column :ebills, :debtors_remarks3, :string, limit: 50
    add_column :ebills, :output, :integer, limit:3
    add_column :ebills, :debtor_trader_id, :integer
    add_column :ebills, :debtor_name,  :string, limit: 50
    add_column :ebills, :debtor_kana,  :string, limit: 40
    add_column :ebills, :assignor_number,  :string, limit: 9
    add_column :ebills, :assignor_kana,  :string, limit: 40
    add_column :ebills, :last_creditor_user_number,  :string, limit: 9
    add_column :ebills, :last_creditor_kana, :string, limit: 40
    add_column :ebills, :last_creditor_bank_code,  :string, limit: 4
    add_column :ebills, :last_creditor_bank_kana,  :string, limit: 15
    add_column :ebills, :last_creditor_branch_code,  :string, limit: 3
    add_column :ebills, :last_creditor_branch_kana,  :string, limit: 15
    add_column :ebills, :last_creditor_account_type, :integer, limit:3
    add_column :ebills, :last_creditor_account_number, :string, limit: 7
    add_column :ebills, :registration_division,  :integer, limit:3

  end
end
