class CreateItem < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.references :merchant, foreign_key: true
      t.integer :unit_price
      t.string :timestamps
    end
  end
end
