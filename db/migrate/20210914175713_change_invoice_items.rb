class ChangeInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    change_column :invoice_items, :id, :bigint, auto_increment: false
  end
end
