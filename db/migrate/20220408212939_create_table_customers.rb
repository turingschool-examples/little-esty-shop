class CreateTableCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :table_customers do |t|
      t.bigint :id
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
