class AddItemStatusToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :item_status, :integer, null: true
  end
end
