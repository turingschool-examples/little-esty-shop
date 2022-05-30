class RemoveItemidandInvoiceIdFromInvoiceItems < ActiveRecord::Migration[5.2]
  def up
    remove_column :invoice_items, :item_id, :integer
    remove_column :invoice_items, :invoice_id, :integer
  end
  def down
    add_column :invoice_items, :item_id, :integer
    add_column :invoice_items, :invoice_id, :integer
  end
end
