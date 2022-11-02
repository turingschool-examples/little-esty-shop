class RemoveStatusFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :status, :integer
  end
end
