class ChangeIntegerLimitInTransactions < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :cc_number, :bigint
  end
end
