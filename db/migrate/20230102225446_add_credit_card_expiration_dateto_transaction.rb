class AddCreditCardExpirationDateToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :credit_card_expiration_date, :string
  end
end
