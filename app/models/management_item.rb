class ManagementItem < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :company

  scope :of_ours, ->(company) { where(company_id: company.id) }
end
