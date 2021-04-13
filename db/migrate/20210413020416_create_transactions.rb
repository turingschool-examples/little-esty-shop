class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :invoice_id
      t.string :credit_card_number
      t.datetime :credit_card_expiration_date
      t.integer :result
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
