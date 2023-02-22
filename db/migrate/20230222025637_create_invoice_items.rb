class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items do |t|
      t.string :item_id
      t.string :invoice_id
      t.string :quantity
      t.string :unit_price
      t.string :status
      
      t.timestamps
    end
  end
end
