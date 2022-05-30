class AddCustomerToInvoices < ActiveRecord::Migration[5.2]
  def up
    add_reference :invoices, :customer, foreign_key: true
  end
  def down
    remove_reference :invoices, :customer, foreign_key: true
  end
end
