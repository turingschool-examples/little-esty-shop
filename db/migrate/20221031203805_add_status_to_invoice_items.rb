class AddStatusToInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    add_column :invoice_items, :status, :string
  end
end
