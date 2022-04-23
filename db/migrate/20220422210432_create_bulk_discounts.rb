class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.decimal :percentage, precision: 3, scale: 2, null: false
      t.integer :quantity, null: false
      t.references :merchant, foreign_key: true, null: false

      t.timestamps
    end
  end
end
