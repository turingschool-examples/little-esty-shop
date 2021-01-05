class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers, id: false do |t|
      t.integer :id, primary_key: true
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
