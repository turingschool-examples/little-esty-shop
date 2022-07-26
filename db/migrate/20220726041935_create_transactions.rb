class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :invoice_id
      t.bigint :credit_card_number
      t.datetime :credit_card_expitation_date
      t.string :result
      t.datetime :created_at
      t.datetime :updated_at
      t.index ["invoice_id"], name: "index_transactions_on_invoice_id"
    end
  end
end
