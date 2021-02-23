class ChangeResultInTransactions < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :result, :integer, using: 'result::integer'
  end
end
