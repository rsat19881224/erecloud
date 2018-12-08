class Admin::TaxRatesController < Admin::BaseController
  permit_attributes :code, :name, :rate, :executed_on, :used
end
