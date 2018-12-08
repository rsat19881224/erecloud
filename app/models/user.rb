class User < ActiveRecord::Base
  acts_as_paranoid
  extend Enumerize

  belongs_to :company

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
  validates_length_of :name, :minimum => 2
  validates_length_of :name, :maximum => 32
  
  enumerize :user_type, in: Settings.enumerize_options.user.user_types, scope: true
  scope :of_ours, ->(company) { where(company_id: company.id) }

  protected
  def password_required?
   !persisted? || (persisted? && password.present?)
  end
end
