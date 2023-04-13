class ChangeResultsToIntegerInTransactions < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :result, :integer, default: 1, using: 'result::integer'
  end
end
