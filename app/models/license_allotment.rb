class LicenseAllotment < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :company
  belongs_to :product
  belongs_to :license

  scope :of_ours, ->(company) { where(company_id: company.id) }
end
