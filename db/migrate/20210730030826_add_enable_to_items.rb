class AddEnableToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :enable, :integer, default: 0
  end
end
