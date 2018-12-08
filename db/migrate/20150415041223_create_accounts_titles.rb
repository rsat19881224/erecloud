# -*- coding: utf-8 -*-
class CreateAccountsTitles < ActiveRecord::Migration
  def change
    create_table :accounts_titles do |t|
      t.integer :company_id            #企業ID
      t.string  :code                  #勘定科目コード
      t.string  :name                  #勘定科目名
      t.string  :kana                  #勘定科目カナ
      t.integer :tax_division_id       #税区分ID
      t.integer :tax_rate_id           #税率区分ID
      t.string  :tax_display_type      #消費税表示方法
      t.string  :round_type            #端数処理方法
      t.integer :business_division_id  #事業区分ID
      t.string  :fund_subject_division #資金科目区分
      t.string  :trader_apply_type     #取引先・補助適用区分
      t.boolean :department_inputed, default: false   #部門入力有無
      t.boolean :analysis1_inputed,  default: false   #拡張補助１入力有無
      t.boolean :analysis2_inputed,  default: false   #拡張補助２入力有無
      t.boolean :analysis3_inputed,  default: false   #拡張補助３入力有無
      t.boolean :analysis4_inputed,  default: false   #拡張補助４入力有無
      t.boolean :analysis5_inputed,  default: false   #拡張補助５入力有無
      t.boolean :analysis6_inputed,  default: false   #拡張補助６入力有無
      t.boolean :analysis7_inputed,  default: false   #拡張補助７入力有無
      t.boolean :analysis8_inputed,  default: false   #拡張補助８入力有無
      t.boolean :analysis9_inputed,  default: false   #拡張補助９入力有無
      t.boolean :analysis10_inputed, default: false   #拡張補助１０入力有無

      t.timestamps
      t.datetime :deleted_at
    end

    add_index :accounts_titles, :code, unique: true
  end
end
