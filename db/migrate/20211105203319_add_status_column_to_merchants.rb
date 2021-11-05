class AddStatusColumnToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :status, :boolean, :default => true
  end
end
