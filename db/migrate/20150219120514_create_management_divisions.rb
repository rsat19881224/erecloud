class CreateManagementDivisions < ActiveRecord::Migration
  def change
    create_table :management_divisions do |t|
      t.string :code #コード
      t.string :name #名称
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
