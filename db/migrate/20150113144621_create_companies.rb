class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :management_division_id #管理区分ID
      t.string :number #管理番号
      t.boolean :affiliated #グループ区分
      t.string :group_number #グループ管理番号
      t.boolean :demanded #請求区分
      t.string :name #企業名
      t.string :postal_code #郵便番号
      t.string :prefecture #都道府県
      t.string :address #住所
      t.string :tel #電話番号
      t.string :fax #FAX番号
      t.string :affiliated_post #担当者部署
      t.string :charge_name #担当者名
      t.string :email #E-mail

      t.timestamps
      t.datetime :deleted_at
	
    end
  end
end
