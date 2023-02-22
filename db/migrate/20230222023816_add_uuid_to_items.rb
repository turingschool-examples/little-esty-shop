class AddUuidToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :uuid, :integer
  end
end
