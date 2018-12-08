class AddColumnToDefaultPayableSites < ActiveRecord::Migration
  def change
    add_column :default_payable_sites, :trader_id, :integer
    add_column :default_payable_sites, :setting_type, :integer
  end
end
