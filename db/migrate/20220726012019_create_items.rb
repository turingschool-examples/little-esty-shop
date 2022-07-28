class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.integer :unit_price, null: false
      t.references :merchant, foreign_key: true
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
 
end
