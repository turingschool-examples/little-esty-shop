class ChangeCreditCardNumberToBeStringInTransactions < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :credit_card_number, :string
  end
end
