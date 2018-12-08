class OperatingDivision < ActiveRecord::Base
  acts_as_paranoid

  validates_presence_of :company_id
  validates_presence_of :name

  belongs_to :company

  scope :of_ours, ->(company) { where(company_id: company.id) }
end
