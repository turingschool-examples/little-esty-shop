class ChangeColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :cc_number, :integer
    remove_column :transactions, :cc_expiration_date, :string
    add_column :transactions, :credit_card_number, :bigint
    add_column :transactions, :credit_card_expiration_date, :date
  end
end
