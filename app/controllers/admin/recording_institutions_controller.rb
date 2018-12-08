class Admin::RecordingInstitutionsController < Admin::BaseController
  permit_attributes  :code, :name, :abbreviation, :recording_number_digit, :user_number_digit
end
