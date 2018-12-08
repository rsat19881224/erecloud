class MenuAuthority < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid

  belongs_to :company
  belongs_to :user
  belongs_to :menu

  enumerize :authority_type, in: Settings.enumerize_options.menu_authority.authority_types, scope: true

  scope :of_ours, ->(company) { where(company_id: company.id) }
end
