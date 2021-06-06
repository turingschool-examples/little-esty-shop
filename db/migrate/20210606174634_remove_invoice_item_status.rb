class RemoveInvoiceItemStatus < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoice_items, :status
  end
end
