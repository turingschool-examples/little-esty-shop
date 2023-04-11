class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items do |t|

      t.integer :quantity, null: false
      t.integer :unit_price, null: false
      t.integer :status, null: false
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
      t.references :item, foreign_key: true, null: false
      t.references :invoice, foreign_key: true, null: false
    end
  end
end
