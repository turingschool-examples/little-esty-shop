class RemoveColumnFromMerchants < ActiveRecord::Migration[5.2]
  def change
    remove_column :merchants, :active, :boolean
  end
end
