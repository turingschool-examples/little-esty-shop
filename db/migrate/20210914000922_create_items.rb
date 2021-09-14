class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items, id: false do |t|
      t.integer :id
      t.string :name
      t.string :description
      t.integer :unit_price
      t.references :merchant, foreign_key: true
      t.datetime :created_at
      t.datetime :updated_at
    end
    execute "ALTER TABLE items ADD PRIMARY KEY (id);"
  end
end
