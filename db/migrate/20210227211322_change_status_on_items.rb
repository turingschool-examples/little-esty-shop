class ChangeStatusOnItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :status, :boolean, default: false
  end
end
