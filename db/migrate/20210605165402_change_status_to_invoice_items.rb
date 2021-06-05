class ChangeStatusToInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    change_column :invoice_items, :status, 'integer USING CAST("status" AS integer)'
  end
end
