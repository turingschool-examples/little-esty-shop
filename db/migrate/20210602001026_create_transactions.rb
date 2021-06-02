class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_enum :transaction_result, %w[failed success]

    create_table :transactions do |t|
      t.enum :result, enum_name: :transaction_result
      t.references :invoice, foreign_key: true
      t.bigint :credit_card_number
      t.string :credit_card_expiration_date
    end
  end
end
