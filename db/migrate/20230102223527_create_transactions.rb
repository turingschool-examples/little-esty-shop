class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :credit_card_number
      t.string :credit_card_exp_date
      t.integer :result
      t.references :invoice, null: false, foreign_key: true
      t.timestamps
    end
  end
end
