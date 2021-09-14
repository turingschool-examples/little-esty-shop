class ChangeMerchants < ActiveRecord::Migration[5.2]
  def change
    change_column :merchants, :id, :bigint, auto_increment: false  
  end
end
