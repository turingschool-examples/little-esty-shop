class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :unit_price
      t.boolean :enabled

      t.references :merchant, foreign_key: true

      t.timestamps
    end
    execute("ALTER SEQUENCE items_id_seq START with 2500 RESTART;")
  end
end
