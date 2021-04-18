class AddColumnToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :enabled, :boolean, default: false
  end
end
