class AnalysisDivisionsController < BaseController
  permit_attributes  :name, :abbreviation, :used, :input_division
end
