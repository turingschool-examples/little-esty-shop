class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :invoice_id
      t.integer :credit_card_number, limit: 8
      t.string :cc_expiration
      t.integer :result
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
