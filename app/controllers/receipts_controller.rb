class ReceiptsController < BaseController
  permit_attributes :auto_number, :receipt_number, :trader_id, :corporation_number, :trader_name1, :trader_name2, :received_on,
                    :printed_on, :total_amount, :tax_8, :tax_10, :tax1, :tax2, :taxable_amount, :stamp_duty, :detail_cash,
                    :check, :bank_transfer, :bill, :bill_count, :offset, :detail_others1, :detail_others2, :provision, :remarks,
                    :divided, :receipt_id, :partingl_number, :bill_made, :receipt_issued, :reissued, :reissued_on, :approved

end
