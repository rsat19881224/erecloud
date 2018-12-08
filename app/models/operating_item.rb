class OperatingItem < ActiveRecord::Base
  acts_as_paranoid

  validates_presence_of :company_id
  validates_presence_of :operating_division_id
  validates_presence_of :name

  belongs_to :company
  belongs_to :operating_division

  scope :of_ours, ->(compny) { where(compny_id: compny.id) }
end
