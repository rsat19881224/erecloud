class Branch < ActiveRecord::Base
  acts_as_paranoid
  
  validates_presence_of :bank_id
  validates_presence_of :code
  validates_presence_of :name
  validates_presence_of :kana

  belongs_to :bank

  def self.ransackable_attributes(auth_object = nil)
    %W(bank_id code name kana)
  end

  def self.ransortable_attributes(auth_object = nil)
    %W(code name kana)
  end
end
