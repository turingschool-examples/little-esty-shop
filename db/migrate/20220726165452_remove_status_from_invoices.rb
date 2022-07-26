class RemoveStatusFromInvoices < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoices, :status, :string
  end
end
