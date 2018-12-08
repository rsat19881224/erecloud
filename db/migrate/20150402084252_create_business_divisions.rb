class CreateBusinessDivisions < ActiveRecord::Migration
  def change
    create_table :business_divisions do |t|
      t.string :code
      t.string :name

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
