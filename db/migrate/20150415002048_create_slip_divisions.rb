class CreateSlipDivisions < ActiveRecord::Migration
  def change
    create_table :slip_divisions do |t|
      t.integer :company_id     #企業ID
      t.string :code            #コード  
      t.string :name            #名称

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
