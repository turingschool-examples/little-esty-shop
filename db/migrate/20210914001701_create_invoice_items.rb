class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items, id: false do |t|
      t.integer :id
      t.references :item, foreign_key: true
      t.references :invoice, foreign_key: true
      t.integer :quantity
      t.integer :unit_price
      t.integer :status
      t.datetime :created_at
      t.datetime :updated_at
    end
    execute "ALTER TABLE invoice_items ADD PRIMARY KEY (id);"
  end
end
