class AddStatusToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :status, :integer
    change_column_default :items, :status, 1
  end
end
