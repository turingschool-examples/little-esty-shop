class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items do |t|
      t.integer :quantity, default: 0
      t.money :unit_price, default: 0
      t.integer :status, default: 0
      t.references :item, foreign_key: true
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
