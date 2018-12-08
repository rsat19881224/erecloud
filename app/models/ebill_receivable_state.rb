class EbillReceivableState < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :ebill
  has_one :recording_institution

  belongs_to :company_bank
  belongs_to :trader
end
