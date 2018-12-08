class OperatingDivisionsController < BaseController
  permit_attributes :name, :abbreviation, :used, :input_division, :division_no
end
