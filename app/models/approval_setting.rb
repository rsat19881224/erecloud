class ApprovalSetting < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid

  belongs_to :company
  belongs_to :menu

  enumerize :approval_type, in: Settings.enumerize_options.approval_setting.approval_types, scope: true

  scope :of_ours, ->(company) { where(company_id: company.id) }
end
