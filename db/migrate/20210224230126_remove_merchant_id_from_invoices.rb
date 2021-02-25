class RemoveMerchantIdFromInvoices < ActiveRecord::Migration[5.2]
  def change
    remove_reference :invoices, :merchant, foreign_key: true
  end
end
