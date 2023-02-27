class ChangeItemStatusToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :status, 'integer USING CAST(status AS integer)'
  end
end
