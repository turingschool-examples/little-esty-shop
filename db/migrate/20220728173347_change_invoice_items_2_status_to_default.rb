class ChangeInvoiceItems2StatusToDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :invoice_items, :status, :integer, default: 0
  end
end
