class ChangeInvoiceStatusColumn < ActiveRecord::Migration[5.2]
  def change
      remove_column :invoices, :status
      add_column :invoices, :status, :integer
  end
end
