class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :credit_card_number, :limit => 8
      t.integer :result

      t.timestamps
    end
  end
end
