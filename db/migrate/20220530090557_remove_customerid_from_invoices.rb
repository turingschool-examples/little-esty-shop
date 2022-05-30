class RemoveCustomeridFromInvoices < ActiveRecord::Migration[5.2]
  def up
    remove_column :invoices, :customer_id, :integer
  end
  def down
    add_column :invoices, :customer_id, :integer
  end
end
