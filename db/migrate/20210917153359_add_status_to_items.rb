class AddStatusToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :status, :string, :null => false, :default => 'Disabled'
  end
end
