class CreateAuthorities < ActiveRecord::Migration
  def change
    create_table :authorities do |t|
      t.integer :code #コード
      t.string :name #名称
      
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
