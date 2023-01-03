class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :invoice, foreign_key: true
      t.integer :credit_card_number, limit: 8
      t.datetime :credit_card_expiration_date
      t.integer :result

      t.timestamps
    end
  end
end
