class Admin::ProductsController < Admin::BaseController
  permit_attributes  :code, :name, :bill_credit_used, :bill_debit_used, :ebill_credit_used, :ebill_debit_used, :factoring_credit_used, :factoring_debit_used, :account_payable_used, :account_receivable_used, :print_option_used, :extended
end
