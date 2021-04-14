class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :unit_price
      t.integer :merchant_id, foreign_key: true
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
