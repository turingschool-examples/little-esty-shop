class AddUniqueIndextoCustomers < ActiveRecord::Migration[5.2]
  def change
    add_index :customers, [:first_name, :last_name], unique: true
  end
end
