class UpdateColumnInvoices < ActiveRecord::Migration[5.2]
  def change
    change_column :invoices, :formatted_created_at, :datetime
  end
end
