# -*- coding: utf-8 -*-
class CompanyBank < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid
  belongs_to :company

  scope :of_ours, ->(company) { where(company_id: company.id) }
  enum account_type: {普通預金: 1, 当座預金: 2, その他: 9}
  validates :account_type, inclusion: {
    in: %w(saving checking others),
    allow_nil: true,
    message: "普通、当座、その他の何れかを選択して下さい。"
  }

  validates :code, uniqueness: {
    scope: :company_id,
    message: '入力した会社銀行コードは既に使用されています'
  }
end
