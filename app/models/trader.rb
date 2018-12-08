# -*- coding: utf-8 -*-
class Trader < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid

  belongs_to :company
  has_one :bank_account, ->(trader) {where(trader_id: trader.id)}, class_name: :TraderBankAccount, inverse_of: :trader
  has_one :receivable
  has_many :trader_bank_accounts, inverse_of: :trader
  has_one :initial_representation_of_data
  has_many :trader_bank_accounts
  accepts_nested_attributes_for :initial_representation_of_data, allow_destroy: true
  accepts_nested_attributes_for :trader_bank_accounts, allow_destroy: true

  enumerize :reference_type, in: Settings.enumerize_options.trader.reference_types, scope: true

  scope :of_ours, ->(company) { where(company_id: company.id) }

  # 契約企業ID
  validates :company_id, presence: true

  # 取引先コード
  validates :code, presence: {
   message: '取引先コードは必須です'
  }
  validates :code, length: {
    maximum: 20,
    too_long: '20文字より多い取引先コードは使用できません。'
  }
  validates :code, uniqueness: {
    scope: :company_id,
    message: '指定した取引先コードは既に使用されています。'
  }
  validates :code, format: {
    with: /\A[a-zA-Z0-9]{1,20}\z/,
    message: '取引先コードには20文字以内で半角英数のみ使用できます。',
    allow_blank: true
  }

  # 法人番号
  validates :corporation_number, length: {
    is: 13,
    allow_nil: true,
    message: '法人番号は13桁です'
  }
  validates :corporation_number, format: {
    with: /\A\d{13}\z/,
    message: '法人番号には数字以外使用できません',
    allow_blank: true,
  }

  # 取引先名カナ
  validates :kana, length: {
    minimum: 0,
    maximum: 50,
    allow_blank: true,
    too_long: '50文字より多い取引先名カナは使用できません'
  }
  validates :kana, format: {
    with: /\A[A-Zｱ-ﾝ0-9\-\/\\()｢｣ﾞﾟ. ]+\z/,
    message: '取引先名カナに使用できない文字が含まれています',
    allow_blank: true
  }
end
