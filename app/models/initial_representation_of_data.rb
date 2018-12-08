# -*- coding: utf-8 -*-
class InitialRepresentationOfData < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :trader, inverse_of: :initial_representation_of_data
  belongs_to :company_bank

  scope :of_traders, ->(trader) { where(trader_id: trader.id) }
end
