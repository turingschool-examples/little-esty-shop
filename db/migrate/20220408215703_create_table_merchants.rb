class CreateTableMerchants < ActiveRecord::Migration[5.2]
  def change
    create_table :table_merchants do |t|
      t.bigint :id
      t.string :name

      t.timestamps
    end
  end
end
