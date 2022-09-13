class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items do |t|
      t.belongs_to :item, foreign_key: true
      t.belongs_to :invoice, foreign_key: true
      t.integer :quantity
      t.integer :unit_price
      t.column :status, :integer, default: 0

      t.timestamps
    end
  end
end
