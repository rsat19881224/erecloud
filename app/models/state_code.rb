class StateCode < ActiveRecord::Base
  acts_as_paranoid

  validates(:division, inclusion: { in: [1, 2] })
end
