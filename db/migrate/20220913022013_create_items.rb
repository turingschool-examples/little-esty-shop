class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :unit_price
      t.string :created_at
      t.string :updated_at
      # t.integer :merchant_id, foreign_key: true

      t.references :merchant, foreign_key: true
    end
  end
end
