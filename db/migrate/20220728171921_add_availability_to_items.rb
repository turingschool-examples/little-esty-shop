class AddAvailabilityToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :availability, :integer, default: 0
  end
end
