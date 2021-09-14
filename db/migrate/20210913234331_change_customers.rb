class ChangeCustomers < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :id, :bigint, auto_increment: false
  end
end
