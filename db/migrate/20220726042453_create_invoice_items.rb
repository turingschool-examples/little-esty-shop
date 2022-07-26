class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items do |t|
      t.integer :item_id
      t.integer :invoice_id
      t.integer :quantity
      t.integer :unit_price
      t.integer :status
      t.datetime :created_at
      t.datetime :updated_at
      t.index ["item_id"], name: "index_invoice_items_on_item_id"
      t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id"
    end
  end
end
