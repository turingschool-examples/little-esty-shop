class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :quanity
      t.integer :unit_price
      t.references :merchant_id, foreign_key: true

      t.timestamps
    end
  end
end
