class Company < ActiveRecord::Base
  after_create :pre_create_objects
  extend Enumerize
  enumerize :prefecture, :in =>  Settings.enumerize_options.prefectures

  acts_as_paranoid
  belongs_to :management_division
  has_many :licenses, inverse_of: :company
  has_many :products, through: :licenses

  has_one :admin_user, ->{where(user_type: "user_admin")}, class_name: :User, inverse_of: :company
  has_many :users, inverse_of: :company

  private
  def pre_create_objects
    DefaultPayableSite.pre_create_default_payable_sites(self)
    OperativeSetting.pre_create_operative_setting(self)
  end
end
