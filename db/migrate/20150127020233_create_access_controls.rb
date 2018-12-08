class CreateAccessControls < ActiveRecord::Migration
  def change
    create_table :access_controls do |t|
      t.integer :user_id #ユーザーID
      t.integer :menu_id #メニューID
      t.integer :authoritie_id #メニュー権限ID
      
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
