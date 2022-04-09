class CreateTableMerchants < ActiveRecord::Migration[5.2]
  def change
    create_table :table_merchants do |t|
      t.bigint :id
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
