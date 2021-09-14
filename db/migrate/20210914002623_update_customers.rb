class UpdateCustomers < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :first_name, :string
    change_column :customers, :last_name, :string
    change_column :customers, :created_at, :datetime
    change_column :customers, :updated_at, :datetime
  end
end
