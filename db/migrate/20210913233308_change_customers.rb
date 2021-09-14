class ChangeCustomers < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :first_name, :string, null: false
    change_column :customers, :last_name, :string, null: false
    change_column :customers, :created_at, :datetime, null: false
    change_column :customers, :updated_at, :datetime, null: false
  end
end
