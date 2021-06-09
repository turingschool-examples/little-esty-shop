class CreateMerchantsCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :merchants_customers do |t|
      t.references :merchant, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
