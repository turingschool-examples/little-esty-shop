class ChangeInvoiceItemsStatus < ActiveRecord::Migration[5.2]
  def up
    change_column :invoice_items, :status, 'integer USING CAST(status AS integer)'
  end

  def down
    change_column :invoice_items, :status, :integer
  end
end
