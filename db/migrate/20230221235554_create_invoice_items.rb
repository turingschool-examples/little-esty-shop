class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items do |t|
      t.belongs_to :item
      t.belongs_to :invoice
      t.integer :quantity
      t.integer :unit_price
      t.integer :status
      
      t.timestamps
    end
  end
end
