class AddDefaultToItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :enabled, :boolean, default: true
  end
end
