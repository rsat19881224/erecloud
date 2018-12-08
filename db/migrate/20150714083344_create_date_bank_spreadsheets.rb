class CreateDateBankSpreadsheets < ActiveRecord::Migration
  def change
    create_table :date_bank_spreadsheets do |t|

      t.timestamps
    end
  end
end
