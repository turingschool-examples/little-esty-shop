class AddUuidToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :uuid, :integer
  end
end
