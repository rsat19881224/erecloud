class Department < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :company
  belongs_to :section_breakdown
  
  scope :of_ours, ->(company) { where(company_id: company.id) }
end
