class CreateSectionBreakdowns < ActiveRecord::Migration
  def change
    create_table :section_breakdowns do |t|
      t.integer :ebill_id #電子記録債権ID
      t.integer :company_id #契約企業ID
      t.integer :type #債権債務区分
      t.integer :department_id #部門ID
      t.integer :department_money #部門金額
      t.integer :segment_id #管理区分
      t.string :remarks #備考
      
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
