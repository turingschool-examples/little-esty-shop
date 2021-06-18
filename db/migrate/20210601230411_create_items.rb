class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description
      t.money :unit_price, default: 0
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
