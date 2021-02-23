class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.decimal :unit_price
      t.references :merchant, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
