class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.references :merchant, foreign_key: true
      t.float :discount_percentage
      t.integer :quantity

      t.timestamps
    end
  end
end
