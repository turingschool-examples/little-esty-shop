class ChangeTableItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :status
    add_column :items, :status, :integer, default: 0
  end
end
