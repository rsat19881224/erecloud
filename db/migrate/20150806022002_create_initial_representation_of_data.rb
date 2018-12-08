# -*- coding: utf-8 -*-
class CreateInitialRepresentationOfData < ActiveRecord::Migration
  def change
    create_table :initial_representation_of_data do |t|
      t.integer :trader_id, null: false                # 取引先ID
      t.integer :pbill_mailing_division, default: 1    # 支払手形郵送区分
      t.integer :pbill_postage_division, default: 0    # 支払手形郵送料区分
      t.integer :pbill_postage                         # 支払手形郵送料
      t.integer :receipt_postage                       # 領収証郵送料
      t.string  :rbill_drawing_bank_code               # 受取手形表示銀行コード
      t.string  :rbill_drawing_bank_name               # 受取手形銀行表示名
      t.string  :rbill_drawing_branch_code             # 受取手形表示支店コード
      t.string  :rbill_drawing_branch_name             # 受取手形表示支店名
      t.integer :pbill_company_bank_id                 # 支払手形振出銀行
      t.integer :ebill_settling_company_bank_id        # 電子記録債権入金銀行
      t.integer :ebill_payment_company_bank_id         # 電子記録債権支払銀行
      t.integer :rfactoring_company_bank_id            # ファクタリング債権入金銀行
      t.integer :pfactoring_company_bank_id            # ファクタリング債務入金銀行
      t.integer :bank_transfer_receipt_company_bank_id # 振込入金銀行
      t.integer :bank_transfer_payment_company_bank_id # 振込支払銀行

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
