class CreateAbridgments < ActiveRecord::Migration
  def change
    create_table :abridgments do |t|
      t.integer :company_id #契約企業ID
      t.string :code        #コード
      t.string :contents    #摘要内容

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
