class ChangeStatusToString < ActiveRecord::Migration[5.2]
  def change
    change_column :invoices, :status, :string
    change_column :invoice_items, :status, :string
  end
end
