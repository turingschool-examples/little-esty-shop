class AddColumntoMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :status, :integer, default: 0
  end
end
