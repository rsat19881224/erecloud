class DateBankSettlementsController < BaseController
  permit_attributes :aggregate_date, :aggregate_target, :company_bank_from, :company_bank_to	
end
