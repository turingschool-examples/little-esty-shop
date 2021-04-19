class AddAbleToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :able, :string, default: "Disabled"
  end
end
