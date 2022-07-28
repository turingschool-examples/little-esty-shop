class ChangeInvoicesItemsStatusToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :invoice_items, :status, :integer, using: 'status::integer'
  end
end
