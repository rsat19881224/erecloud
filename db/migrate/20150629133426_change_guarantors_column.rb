class ChangeGuarantorsColumn < ActiveRecord::Migration
  def change
    change_column :guarantors, :user_number, 'integer USING CAST(user_number AS integer)'
    rename_column :guarantors, :user_number, :trader_id
    rename_column :guarantors, :guarantor_name_kana, :guarantor_kana
  end
end
