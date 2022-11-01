class ChangeStatusInInvoices < ActiveRecord::Migration[5.2]
  def change
    change_column :invoices, :status, :integer, using: 'status::integer'
  end
end
