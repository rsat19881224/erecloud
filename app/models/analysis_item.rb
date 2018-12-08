class AnalysisItem < ActiveRecord::Base
  acts_as_paranoid

  validates_presence_of :analysis_division_id
  validates_presence_of :name

  belongs_to :company
  belongs_to :analysis_division

  scope :of_ours, ->(company) { where(company_id: company.id) }
end
