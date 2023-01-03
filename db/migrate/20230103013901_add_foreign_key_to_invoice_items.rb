class AddForeignKeyToInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoice_items, :invoice_id
    remove_column :invoice_items, :item_id
    
    add_reference :invoice_items, :item, foreign_key: true
    add_reference :invoice_items, :invoice, foreign_key: true
  end
end
