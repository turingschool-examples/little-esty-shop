class AddMerchantToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :merchants, foreign_key: true
  end
end
