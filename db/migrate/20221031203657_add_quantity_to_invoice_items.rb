class AddQuantityToInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    add_column :invoice_items, :quantity, :integer
  end
end
