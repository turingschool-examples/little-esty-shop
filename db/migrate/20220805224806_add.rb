class Add < ActiveRecord::Migration[5.2]
  def change
    add_column :bulk_discounts, :merchant_id, :integer, foreign_key: true
  end
end
