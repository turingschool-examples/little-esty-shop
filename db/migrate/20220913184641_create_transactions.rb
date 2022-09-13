class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :invoice_id
      t.bigint :credit_card_number
      t.integer :credit_card_expiration_date
      t.integer :result
      t.timestamps
    end
  end
end
