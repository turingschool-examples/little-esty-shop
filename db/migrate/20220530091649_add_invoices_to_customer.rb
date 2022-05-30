class AddInvoicesToCustomer < ActiveRecord::Migration[5.2]
  def up
    add_reference :customers, :invoice, foreign_key: true
  end
  def down
    remove_reference :customers, :invoice, foreign_key: true
  end
end
