class AddUuidToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :uuid, :integer
  end
end
