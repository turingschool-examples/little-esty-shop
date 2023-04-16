class AddEnabledOrDisabledStatusToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :enabled, :boolean, default: true, null: false
  end
end
