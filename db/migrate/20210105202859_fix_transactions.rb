class FixTransactions < ActiveRecord::Migration[5.2]
  def change
    change_table :transactions do |t|
      t.references :invoice
      t.bigint :credit_card_number
      t.date :credit_card_expiration_date
      t.integer :result
      t.timestamps
    end
  end
end
