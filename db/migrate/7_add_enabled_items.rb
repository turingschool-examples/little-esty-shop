class AddEnabledItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :enabled, :integer, default: 0, null: true
  end
end
