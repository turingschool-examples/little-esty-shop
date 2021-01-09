class AddStatusToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :enabled, :boolean, null: false, default: false
  end
end
