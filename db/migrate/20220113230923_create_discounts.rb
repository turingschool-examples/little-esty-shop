class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.references :merchant, foreign_key: true
      t.integer :min_quantity
      t.integer :percent_off
    end
  end
end
