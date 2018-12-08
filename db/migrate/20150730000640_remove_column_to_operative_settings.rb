class RemoveColumnToOperativeSettings < ActiveRecord::Migration
  def change
    remove_column :operative_settings, :is_use_valuation_account_of_bill
    remove_column :operative_settings, :is_use_valuation_account_of_ebill
  end
end
