class AddToResultToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :result, :string
  end
end
