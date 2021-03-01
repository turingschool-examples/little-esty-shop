class AddFormatedCreatedAtToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :formatted_created_at, :datetime
  end
end
