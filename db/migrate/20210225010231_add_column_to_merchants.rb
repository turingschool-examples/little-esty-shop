class AddColumnToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :active, :boolean, default: true
  end
end
