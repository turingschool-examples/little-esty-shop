class RemoveInvoiceidFromTransactions < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :invoice_id, :integer
  end
end
