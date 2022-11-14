class CreateDiscount < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.bigint :merchant_id
      t.integer :quantity_threshhold
      t.float :percentage
      t.references :invoice_item, foreign_key: true
    end
  end
end
