class AddStatusToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :status, :boolean, default: false
  end
end
