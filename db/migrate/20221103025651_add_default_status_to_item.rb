class AddDefaultStatusToItem < ActiveRecord::Migration[5.2]
  def change
    change_column_default :items, :status, "Disabled"
  end
end
