class ChangeTransactionsResultDataType < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :result, :string
  end
end
