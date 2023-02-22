class AddUuidToInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    add_column :invoice_items, :uuid, :integer
  end
end
