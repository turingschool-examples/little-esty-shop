class ChangeStatusToItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :status, :string, :default => 'disabled'
  end
end
