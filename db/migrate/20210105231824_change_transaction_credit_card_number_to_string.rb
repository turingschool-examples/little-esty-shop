class ChangeTransactionCreditCardNumberToString < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :credit_card_number
    add_column :transactions, :credit_card_number, :string
  end
end
