class RemoveColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoices, :customer_id
  
    add_reference :invoices, :customer, foreign_key: true
  end
end
