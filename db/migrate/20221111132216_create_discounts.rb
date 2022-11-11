class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.integer :quantity_threshold
      t.integer :percentage_discount

      t.timestamps
    end
  end
end
