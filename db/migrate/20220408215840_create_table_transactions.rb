class CreateTableTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :table_transactions, id: false do |t|
      t.bigint :id
      t.references :invoice, foreign_key: true
      t.string :credit_card_number
      t.string :credit_card_expiration_date
      t.integer :result
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
