class AddManufactureCertificateListToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :manufacture_certificate_list, :string
  end
end
