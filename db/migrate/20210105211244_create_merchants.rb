class CreateMerchants < ActiveRecord::Migration[5.2]
  def change
    create_table :merchants, id: false do |t|
      t.integer :id, primary_key: true
      t.string :name

      t.timestamps
    end
  end
end
