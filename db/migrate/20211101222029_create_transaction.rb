class CreateTransaction < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions, :id => false do |t|
      t.integer :id
      t.integer :invoice_id
      t.string :credit_card_number
      t.string :credit_card_expiration_date
      t.string :result

      t.timestamps 
    end
  end
end
