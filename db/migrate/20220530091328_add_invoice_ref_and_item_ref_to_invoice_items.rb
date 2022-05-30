class AddInvoiceRefAndItemRefToInvoiceItems < ActiveRecord::Migration[5.2]
  def up
    add_reference :invoice_items, :invoice, foreign_key: true
    add_reference :invoice_items, :item, foreign_key: true
  end
  def down
    remove_reference :invoice_items, :invoice, foreign_key: true
    remove_reference :invoice_items, :item, foreign_key: true
  end
end
