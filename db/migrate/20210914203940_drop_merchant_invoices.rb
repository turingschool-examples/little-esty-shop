class DropMerchantInvoices < ActiveRecord::Migration[5.2]
  def change
    drop_table :merchant_invoices
  end
end
