class RemoveStatusFromInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoice_items, :status, :string
  end
end
