class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table(:invoice_items) do |t|
      t.integer(:item_id)
      t.integer(:invoice_id)
      t.integer(:quantity)
      t.integer(:unit_price)
      t.integer(:status,       default: 0)
      t.timestamps
    end
  end
end
