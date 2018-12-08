class StampTax < ActiveRecord::Base
  acts_as_paranoid
  extend Enumerize

  enumerize :tax_type, :in =>  Settings.enumerize_options.tax_types
end
