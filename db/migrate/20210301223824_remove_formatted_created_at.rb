class RemoveFormattedCreatedAt < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoices, :formatted_created_at
  end
end
