class AddMerchantRefToItems < ActiveRecord::Migration[5.2]
  def up
    add_reference :items, :merchant, foreign_key: true
  end
  def down
    remove_reference :items, :merchant, foreign_key: true
  end
end
