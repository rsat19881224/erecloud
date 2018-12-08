class AccountsSetting < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid
  
  enumerize :abridgment_method, in:  Settings.enumerize_options.abridgment_method
  enumerize :payment_type, in:  Settings.enumerize_options.payment_type
end
