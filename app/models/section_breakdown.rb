class SectionBreakdown < ActiveRecord::Base
  belongs_to :receivable, foreign_key: 'ebill_id'
  has_one :department
  acts_as_paranoid
end
