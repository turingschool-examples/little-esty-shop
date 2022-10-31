class AddCustomersToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_reference :invoices, :customer, foreign_key: true
  end
end
