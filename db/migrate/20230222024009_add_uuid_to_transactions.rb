class AddUuidToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :uuid, :integer
  end
end
