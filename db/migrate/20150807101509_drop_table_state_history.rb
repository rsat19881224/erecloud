class DropTableStateHistory < ActiveRecord::Migration
  def change
    drop_table :state_histories
  end
end
