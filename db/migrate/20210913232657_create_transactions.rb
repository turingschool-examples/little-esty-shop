class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :invoice, foreign_key: true, null: false
      t.integer :credit_card_number, null: false
      t.string :credit_card_expiration_date
      t.integer :result, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
