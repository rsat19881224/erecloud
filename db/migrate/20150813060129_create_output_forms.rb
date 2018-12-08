class CreateOutputForms < ActiveRecord::Migration
  def change
    create_table :output_forms do |t|
      t.integer :pattern_division #パターン区分
      t.integer :company_id #契約企業ID
      t.integer :delimiter #区切文字
      t.integer :character_code #文字コード
      t.integer :number_of_slip_number_figures #伝票番号桁数
      t.integer :attached_0_befor #前0有無
      t.string :date_output_Format #日付出力形式
      t.string :filename_extension #ファイルの拡張子
      t.string :extension #拡張子名
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
