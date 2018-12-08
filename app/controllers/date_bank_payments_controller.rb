class DateBankPaymentsController < BaseController
  permit_attributes :aggregate_date, :aggregate_criteria, :aggregate_target, :facts, :company_bank_from, :company_bank_to	
end
