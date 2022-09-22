class AddMerchantToBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    add_reference :bulk_discounts, :merchant, foreign_key: true
  end
end
