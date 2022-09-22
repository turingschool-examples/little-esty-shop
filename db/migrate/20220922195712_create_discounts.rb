class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.float :bulk_discount
      t.integer :item_threshold
      t.references :merchant, foreign_key: true

      t.timestamps 
    end
  end
end
