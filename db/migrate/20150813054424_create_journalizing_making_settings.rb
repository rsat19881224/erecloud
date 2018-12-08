class CreateJournalizingMakingSettings < ActiveRecord::Migration
  def change
    create_table :journalizing_making_settings do |t|
      t.integer :company_id #契約企業ID
      t.integer :credit_debt_division #債権債務区分
      t.integer :state_codes_id #てん末ID
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
