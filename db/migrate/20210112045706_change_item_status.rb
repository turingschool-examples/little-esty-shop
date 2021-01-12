class ChangeItemStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :items, :status, 1
  end
end
