class CreateBankHolidays < ActiveRecord::Migration
  def change
    create_table :bank_holidays do |t|
      t.datetime :holiday

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
