class AddStatusToMerchant < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :status, :integer, default: 1
  end
end
