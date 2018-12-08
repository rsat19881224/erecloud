class CreateSecurityPolicies < ActiveRecord::Migration
  def change
    create_table :security_policies do |t|
      t.integer :company_id                    #契約企業ID
      t.string :min_characters                 #パスワード最小文字数
      t.boolean :included_three_kinds          #英数字混在3種類以上の必要性
      t.boolean :included_account              #アカウントを含むパスワードの許可
      t.string :number_of_history_generations  #履歴世代管理
      t.string :valid_period                   #パスワード有効期間日数
      t.string :change_prohibition_period      #パスワード変更禁止期間
      t.string :lockout_setting                #ロックアウト設定
      t.string :time_elapsed                   #ロックアウト自動解除時間

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
