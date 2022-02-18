class AddMerchantsToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :merchant, foreign_key: true
  end
end
