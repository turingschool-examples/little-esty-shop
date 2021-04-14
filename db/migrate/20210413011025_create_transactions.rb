class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :invoice, foreign_key: true
      t.integer :cc_number
      t.string :cc_expiration_date
      t.integer :result

      t.timestamps
    end
  end
end
