class AddEnabledToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :enabled, :boolean, default: true
  end
end
