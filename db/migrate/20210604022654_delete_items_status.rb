class DeleteItemsStatus < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :status
  end
end
