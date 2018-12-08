class Approver < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid

  belongs_to :company
  belongs_to :user
  belongs_to :menu

  enumerize :approver_type, in: Settings.enumerize_options.approver.approver_types, scope: true

  scope :of_ours, ->(company) { where(company_id: company.id) }
end
