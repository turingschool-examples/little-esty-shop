class ChangeStatusToInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    InvoiceItem.where(status: 'pending').update_all(status: 0)
    InvoiceItem.where(status: 'packaged').update_all(status: 1)
    InvoiceItem.where(status: 'shipped').update_all(status: 2)
    change_column :invoice_items, :status, 'integer USING CAST("status" AS integer)'
  end
end
