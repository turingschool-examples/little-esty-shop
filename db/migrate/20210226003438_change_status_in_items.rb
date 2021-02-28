class ChangeStatusInItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :status, :boolean, :default => true
  end
end
