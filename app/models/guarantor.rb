class Guarantor < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :receivable, foreign_key: 'ebill_id'
  belongs_to :trader
end
