class ChangeUnitPriceToFloat < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :unit_price
    add_column :items, :unit_price, :float
  end
end
