class TaxDivision < ActiveRecord::Base
  acts_as_paranoid
  extend Enumerize

  enumerize :taxed, :in =>  Settings.enumerize_options.taxeds
end
