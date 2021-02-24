class ChangeInvoiceItemStatusColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoice_items, :status
    add_column :invoice_items, :status, :integer
  end
end
