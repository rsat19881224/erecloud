class Bank < ActiveRecord::Base
  acts_as_paranoid

  has_many :branchs
  validates_presence_of :code
  validates_presence_of :name
  validates_presence_of :kana

  def self.ransackable_attributes(auth_object = nil)
    %W(code name kana)
  end

  def ransortable_attributes(auth_object = nil)
    %W(code name kana)
  end
end
