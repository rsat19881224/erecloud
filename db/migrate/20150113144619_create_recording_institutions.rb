class CreateRecordingInstitutions < ActiveRecord::Migration
  def change
    create_table :recording_institutions do |t|
      t.string :code #コード
      t.string :name #名称
      t.string :abbreviation #略称
      t.string :recording_number_digit #記録番号桁数
      t.string :user_number_digit #利用者番号桁数

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
