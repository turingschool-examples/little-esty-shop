class ChangeTransactions < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :id, :bigint, auto_increment: false
    change_column_null :transactions, :credit_card_expiration_date, :integer, null: true
  end
end
