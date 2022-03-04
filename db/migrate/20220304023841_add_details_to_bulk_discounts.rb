class AddDetailsToBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    add_column :bulk_discounts, :name, :string
    add_column :bulk_discounts, :percent_discount, :float
    add_column :bulk_discounts, :quantity_threshold, :integer
  end
end
