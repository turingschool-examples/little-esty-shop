class ChangeInvoiceDateFormatToString < ActiveRecord::Migration[5.2]
  def change
    change_column :invoices, :formatted_created_at, :string
  end
end
