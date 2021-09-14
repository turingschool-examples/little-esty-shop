class ChangeInvoices < ActiveRecord::Migration[5.2]
  def change
    change_column :invoices, :id, :bigint, auto_increment: false
  end
end
