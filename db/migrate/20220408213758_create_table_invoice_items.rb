class CreateTableInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :table_invoice_items, id: false do |t|
      t.references :item, foreign_key: true
      t.references :invoice, foreign_key: true
      t.integer :quantity
      t.integer :unit_price
      t.integer :status, default: 0
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
