class CreateTableCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :table_customers, id: false do |t|
      t.bigint :id
      t.string :first_name
      t.string :last_name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
