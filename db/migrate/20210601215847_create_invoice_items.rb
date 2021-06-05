class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items do |t|
      t.integer :quantity
      t.integer :unit_price
      t.string :status 
      t.references :invoice, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
    execute("ALTER SEQUENCE invoice_items_id_seq START with 1000 RESTART;")
  end
end
