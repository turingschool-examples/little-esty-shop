class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
    end
  end
end
