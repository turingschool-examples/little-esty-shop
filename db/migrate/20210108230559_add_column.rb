class AddColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :shipping_address, :string
  end
end
