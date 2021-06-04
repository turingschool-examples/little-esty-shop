class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
    execute("ALTER SEQUENCE customers_id_seq START with 1000 RESTART;")
  end
end
