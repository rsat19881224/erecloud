class Ebill < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :company
  has_many :ebill_receivable_states
  belongs_to :state_code, primary_key: :code, foreign_key: :state_code_id

  scope :of_ours, ->(company) { where(company_id: company.id) }
end
