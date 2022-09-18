class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      # t.integer :invoice_id, foreign_key: true
      t.bigint :credit_card_number
      t.integer :credit_card_expiration_date
      t.integer :result
      t.datetime :created_at
      t.datetime :updated_at

      t.references :invoice, foreign_key: true
    end
  end
end
