class Receipt < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid

  belongs_to :company
  belongs_to :trader,   :class_name => "Trader", :foreign_key => :trader_id
  belongs_to :receipt,   :class_name => "Receipt", :foreign_key => :receipt_id

  scope :of_ours, ->(company) { where(company_id: company.id) }
  enumerize :divided, in: Settings.enumerize_options.divided, scope: true
  enumerize :bill_made, in: Settings.enumerize_options.bill_made, scope: true
  enumerize :approved, in: Settings.enumerize_options.approved, scope: true
end
