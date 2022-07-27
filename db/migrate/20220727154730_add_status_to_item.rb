class AddStatusToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :status, :integer, default: "disabled"
  end
end
