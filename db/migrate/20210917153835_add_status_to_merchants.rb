class AddStatusToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :status, :string, :null => false, :default => 'Disabled'
  end
end
