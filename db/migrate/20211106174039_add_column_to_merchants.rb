class AddColumnToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :status, :string, default: 'enabled'
  end
end
