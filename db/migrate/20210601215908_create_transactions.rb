class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :credit_card_number
      t.string :credit_card_expiration_date
      t.string :result
      t.references :invoice, foreign_key: true

      t.timestamps
    end
    execute("ALTER SEQUENCE transactions_id_seq START with 1000 RESTART;")
  end
end
