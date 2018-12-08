class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.integer :company_id #契約企業ID
      t.string :code #コード
      t.string :name #名称
      t.string :name_kana #名称カナ
      t.string :abbreviation #略称

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
