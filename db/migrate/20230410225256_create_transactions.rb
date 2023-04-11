class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|

      t.string :credit_card_number, null: false
      t.date :credit_card_expiration_date
      t.boolean :result, null: false
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
      t.references :invoice, foreign_key: true, null: false
    end
  end
end
