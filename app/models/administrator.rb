class Administrator < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enumerize :administrator_type, in: Settings.enumerize_options.administrator.administrator_types, scope: true
end
