class CreateJournalizingDataOutputSettings < ActiveRecord::Migration
  def change
    create_table :journalizing_data_output_settings do |t|
      t.integer :company_id #契約企業ID
      t.integer :output_form_id #前回出力形式ID
      t.string :serial_number_method #採番基準
      t.string :last_slip_number #最終伝票No
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
