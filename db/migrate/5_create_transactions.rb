class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.belongs_to :invoice, foreign_key: true
      t.bigint :credit_card_number
      t.datetime :credit_card_expiration_date
      t.column :result, :integer, default: 0

      t.timestamps
    end
  end
end
