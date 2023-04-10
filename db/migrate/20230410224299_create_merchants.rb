class CreateMerchants < ActiveRecord::Migration[5.2]
  def change
    create_table :merchants do |t|
      
      t.string :name, null: false
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
    end
  end
end
