class ChangeStatusToItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :status, :integer, default: 1
  end
end
