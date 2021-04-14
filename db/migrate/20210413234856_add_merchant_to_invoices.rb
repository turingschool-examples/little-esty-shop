class AddMerchantToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_reference :invoices, :merchants, foreign_key: true
  end
end
