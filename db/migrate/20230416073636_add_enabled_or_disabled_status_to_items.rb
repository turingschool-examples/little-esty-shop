class AddEnabledOrDisabledStatusToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :is_enabled, :boolean, default: false, null: false
  end
end
