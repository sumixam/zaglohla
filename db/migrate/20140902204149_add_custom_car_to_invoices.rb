class AddCustomCarToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :custom_car, :string
  end
end
