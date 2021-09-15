class ChangeTables < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :id, :bigint, auto_increment: true
    change_column :invoices, :id, :bigint, auto_increment: true
    change_column :invoice_items, :id, :bigint, auto_increment: true
    change_column :transactions, :id, :bigint, auto_increment: true
    change_column :customers, :id, :bigint, auto_increment: true
    change_column :merchants, :id, :bigint, auto_increment: true
  end
end
