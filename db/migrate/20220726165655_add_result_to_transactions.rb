class AddResultToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :result, :integer
  end
end
