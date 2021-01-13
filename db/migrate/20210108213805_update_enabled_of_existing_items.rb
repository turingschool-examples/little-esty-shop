class UpdateEnabledOfExistingItems < ActiveRecord::Migration[5.2]
  def change
    Item.update_all({enabled: true})
  end
end
