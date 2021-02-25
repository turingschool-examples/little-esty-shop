class ChangeColumnNameMerchants < ActiveRecord::Migration[5.2]
  def change
    change_column :merchants, :status, :string, default: "Disabled"
  end
end
