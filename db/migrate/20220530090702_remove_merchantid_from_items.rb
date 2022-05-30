class RemoveMerchantidFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :merchant_id, :integer
  end
end
