class ChangePercentageToIntegerInBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    change_column :bulk_discounts, :percentage, :integer
  end
end
