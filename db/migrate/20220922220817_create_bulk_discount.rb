class CreateBulkDiscount < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.integer :threshold
      t.integer :discount
      t.belongs_to :merchant, foreign_key: true
    end
  end
end
