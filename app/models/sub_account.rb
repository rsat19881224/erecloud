class SubAccount < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid

  validates_presence_of :account_id
  validates_presence_of :code
  validates_presence_of :name

  belongs_to :company
  belongs_to :account
  belongs_to :tax_division
  belongs_to :tax_rate
  belongs_to :business_division

end
