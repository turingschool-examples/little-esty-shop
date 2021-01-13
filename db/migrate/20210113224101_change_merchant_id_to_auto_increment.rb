class ChangeMerchantIdToAutoIncrement < ActiveRecord::Migration[5.2]
  def change
    change_column :merchants, :id, :serial false do |t|

end
