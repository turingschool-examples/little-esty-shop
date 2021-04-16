class AddColumnToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :enable, :boolean, default: true
  end
end
