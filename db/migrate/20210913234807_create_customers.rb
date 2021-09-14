class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers, id: false do |t|
      t.integer :id
      t.string :first_name
      t.string :last_name
      t.datetime :created_at
      t.datetime :updated_at
    end
    execute "ALTER TABLE customers ADD PRIMARY KEY (id);"
  end
end
