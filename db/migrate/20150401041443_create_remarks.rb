class CreateRemarks < ActiveRecord::Migration
  def change
    create_table :remarks do |t|
      t.integer :company_id
      t.string :code
      t.string :content

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
