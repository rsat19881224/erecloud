class LicenseAllotmentsController < BaseController
  permit_attributes :user_id, :license_id
  helper_method :number_of_create_limit, :restrict_create, :create_quantity, :license_collection

  def ordering(search)
    model.of_ours(@my_company)
  end

  def number_of_create_limit(company)
    License.where(company_id: company.id).inject(0) {|acm, l| acm + l.number_of_license }
  end

  def restrict_create
    create_quantity.blank?
  end

  # return {product_name => quantity}
  def create_quantity(company)
    licenses = License.of_ours(@my_company).map do |l|
      {
       product_name: Product.find_by_id(l.product_id).name,
       quantity: (l.number_of_license - LicenseAllotment.where(license_id: l.id).count)
      }
    end
    licenses.select {|l| l[:quantity] > 0 }
  end

  def license_collection
    licenses = License.of_ours(@my_company).select do |l|
      LicenseAllotment.where(license_id: l.id).count < l.number_of_license
    end
  end
end
