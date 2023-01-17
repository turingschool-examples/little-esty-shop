class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :invoice, foreign_key: true
      t.integer :credit_card
      t.string :result
      t.date :credit_card_expiration_date

      t.timestamps
    end
  end
end
