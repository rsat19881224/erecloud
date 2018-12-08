class AddColumnToEbillReceivableStates < ActiveRecord::Migration
  def change
    add_column :ebill_receivable_states, :deleted_at, :datetime
    add_column :ebill_receivable_states, :created_at, :datetime
    add_column :ebill_receivable_states, :updated_at, :datetime
  end
end
