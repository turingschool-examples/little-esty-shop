class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.references :merchant, foreign_key: true
      t.text :description
      t.integer :unit_price

      t.timestamps
    end
  end
end
