class CreateTableItems < ActiveRecord::Migration[5.2]
  def change
    create_table :table_items do |t|
      t.bigint :id
      t.string :name
      t.string :description
      t.integer :unit_price
      t.references :merchant, foreign_key: true
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
