class ChangeStatusToBeIntegerInInvoices < ActiveRecord::Migration[5.2]
  def change
    change_column :invoices, :status, :integer, using: 'status::integer', default: 0
  end
end
