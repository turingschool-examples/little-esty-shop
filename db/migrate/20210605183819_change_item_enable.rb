class ChangeItemEnable < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :enabled, 'integer USING CAST("enabled" AS integer)'
  end
end
