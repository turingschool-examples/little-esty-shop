class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :unit_price
      t.datetime :created_at
      t.datetime :updated_at

      t.references :merchant, foreign_key: true
    end
  end
end
