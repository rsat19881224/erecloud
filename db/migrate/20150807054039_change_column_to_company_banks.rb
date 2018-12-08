class ChangeColumnToCompanyBanks < ActiveRecord::Migration
  def change
    change_column :company_banks, :company_id, :integer, null: false
    change_column :company_banks, :code, :string, null: false

    add_index :company_banks, [:company_id, :code], unique: true
  end
end
