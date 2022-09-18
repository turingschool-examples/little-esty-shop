class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items do |t|
      t.integer :quantity
      t.integer :unit_price
      t.integer :status, default: 0
      t.datetime :created_at
      t.datetime :updated_at

      t.references :invoice, foreign_key: true
      t.references :item, foreign_key: true
    end
  end
end
