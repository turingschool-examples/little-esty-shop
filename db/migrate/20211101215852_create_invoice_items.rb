class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items, :id => false do |t|
      t.integer :id
      t.integer :item_id
      t.integer :invoice_id
      t.integer :quantity
      t.integer :unit_price
      t.column :status, :integer, default: 0

      t.timestamps 
    end
  end
end
