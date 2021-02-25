class AddColumnToMerchants1 < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :status, :string, default: "Active"
  end
end
