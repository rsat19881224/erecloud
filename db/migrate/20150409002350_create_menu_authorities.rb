class CreateMenuAuthorities < ActiveRecord::Migration
  def change
    create_table :menu_authorities do |t|
      t.integer :company_id
      t.integer :user_id
      t.integer :menu_id
      t.string  :authority_type

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
