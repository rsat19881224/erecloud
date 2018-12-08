class CreateStateCodes < ActiveRecord::Migration
  def change
    create_table :state_codes do |t|
      t.integer :code
      t.integer :division
      t.string  :bill
      t.string  :ebill
      t.string  :factoring
      t.string  :cash_payment

      t.timestamps
      t.datetime :deleted_at
    end
  end
end

