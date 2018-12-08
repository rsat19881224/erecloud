class ChangeColumnToEbillReceivableStateHistory < ActiveRecord::Migration
  def change
    add_column :ebill_receivable_states, :company_id, :integer
    add_column :ebill_receivable_states, :process_type, :string
    add_column :ebill_receivable_states, :menu_id, :integer
    add_column :ebill_receivable_states, :computer_name, :string
    add_column :ebill_receivable_states, :user_id, :integer
    add_column :ebill_receivable_states, :registered_at, :datetime
    add_column :ebill_receivable_states, :ebill_receivable_state_id, :integer
  end
end
