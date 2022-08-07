class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.integer :percentage, null: false
      t.integer :quantity_threshold, null: false

      t.timestamps
    end
  end
end
