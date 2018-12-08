class SlipHeader < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  belongs_to :renew_user, :class_name => "User", :foreign_key => "renew_user_id"
  belongs_to :ebill, :class_name => "Ebill", :foreign_key => "bill_id"
  belongs_to :ebill_receivable_state, :class_name => "EbillReceivableState", :foreign_key => "bill_id"

  has_many :slip_detail
end
