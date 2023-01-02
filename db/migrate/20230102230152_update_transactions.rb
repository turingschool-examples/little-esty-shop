class UpdateTransactions < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :credit_card_number, :bigint
    change_column :transactions, :credit_card_expiration_date, :string
  end
end
