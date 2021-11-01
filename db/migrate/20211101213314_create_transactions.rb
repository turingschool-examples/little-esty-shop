class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions, id: false do |t|
      t.integer :id 
      t.references :invoice, foreign_key: true
      t.string :credit_card_number
      t.integer :credit_card_expiration_date
      t.string :result
      t.datetime :created_at
      t.datetime :updated_at
    end
    execute 'ALTER TABLE transactions ADD PRIMARY KEY (id);'
  end
end
