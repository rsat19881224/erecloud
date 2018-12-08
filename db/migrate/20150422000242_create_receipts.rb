class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.integer :company_id           #契約企業ID
      t.string  :auto_number          #管理番号
      t.string  :receipt_number       #領収証番号
      t.integer  :trader_id           #請求先ID
      t.string  :corporation_number   #請求先法人番号
      t.string  :trader_name1         #請求先名1
      t.string  :trader_name2         #請求先名2
      t.date  :received_on            #入金日付
      t.date  :printed_on             #領収証印字日付
      t.string  :total_amount         #領収金額
      t.string  :tax_8                #消費税金額 8%
      t.string  :tax_10               #消費税金額 10%
      t.string  :tax1                 #消費税金額 予備1
      t.string  :tax2                 #消費税金額 予備2
      t.string  :taxable_amount       #印紙税計算対象金額
      t.string  :stamp_duty           #印紙税額
      t.string  :detail_cash          #内訳 現金
      t.string  :check                #内訳 小切手
      t.string  :bank_transfer        #内訳 振込
      t.string  :bill                 #内訳 手形
      t.string  :bill_count           #手形枚数
      t.string  :offset               #内訳 相殺
      t.string  :detail_others1       #内訳 予備1
      t.string  :detail_others2       #内訳 予備2
      t.string  :provision            #但し書き
      t.string  :remarks              #備考
      t.string  :divided              #分割ステータス
      t.integer  :receipt_id          #分割元領収証ID
      t.string  :partingl_number      #分割番号
      t.string  :bill_made            #手形データ作成区分
      t.boolean  :receipt_issued      #発行フラグ
      t.boolean  :reissued            #再発行区分
      t.date  :reissued_on            #再発行日付
      t.integer  :approved            #承認フラグ


      t.timestamps
      t.datetime :deleted_at
    end
  end
end
