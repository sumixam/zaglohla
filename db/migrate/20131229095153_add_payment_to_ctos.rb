class AddPaymentToCtos < ActiveRecord::Migration
  def change
    add_column :ctos, :payment_cash, :boolean
    add_column :ctos, :payment_card, :boolean
    add_column :ctos, :payment_bill, :boolean
  end
end
