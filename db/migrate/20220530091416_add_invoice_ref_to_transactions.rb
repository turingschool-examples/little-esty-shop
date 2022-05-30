class AddInvoiceRefToTransactions < ActiveRecord::Migration[5.2]
  def up
    add_reference :transactions, :invoice, foreign_key: true
  end
  def down
    remove_reference :transactions, :invoice, foreign_key: true
  end
end
