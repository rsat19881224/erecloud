class OperatingDivisionSetting < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid

  validates_presence_of :company_id
  validates_presence_of :operating_division_id

  belongs_to :company
  belongs_to :operating_division

  enumerize :input_type , in: Settings.enumerize_options.operating_division_setting.input_types, scope: true

  scope :of_ours, ->(compny) { where(compny_id: compny.id) }
end
