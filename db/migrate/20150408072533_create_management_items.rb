class CreateManagementItems < ActiveRecord::Migration
  def change
    create_table :management_items do |t|
      t.integer :company_id #契約企業ID
      t.string :code        #コード
      t.string :name        #名前

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
