class AddColumnToSlipDetail < ActiveRecord::Migration
  def change
    add_column :slip_details, :tax_display, :integer
    add_column :slip_details, :round, :integer
  end
end
