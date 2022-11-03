class AddStatusToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :status, :integer
    change_column_default :merchants, :status, 1
  end
end
