class AddUnitPriceToInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    add_column :invoice_items, :unit_price, :integer
  end
end
