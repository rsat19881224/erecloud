class License < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid

  belongs_to :product
  belongs_to :company

  enumerize :license_type, in: Settings.enumerize_options.license.license_types, scope: true

  scope :of_ours, ->(company) { where(company_id: company.id) }
end
