class CreateDataSubstitutions < ActiveRecord::Migration
  def change
    create_table :data_substitutions do |t|
      t.integer :output_orders_id #出力順ID
      t.integer :output_form_id #出力形式ID
      t.string :output_item #出力項目
      t.string :substituted_previous_value #置換前項目
      t.string :substituted_value #置換値
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
