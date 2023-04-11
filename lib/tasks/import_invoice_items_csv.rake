require 'csv'

namespace :csv_load do
  desc "Import invoice items from csv file"
  task :invoice_items => :environment do
    CSV.foreach("db/data/invoice_items.csv", headers: true) do |row|
      InvoiceItem.find_or_create_by!(id: row['id']) do |invoice_item|
        invoice_item.quantity = row['quantity'].to_i
        invoice_item.status = row['status'].to_i
        invoice_item.unit_price = row['unit_price'].to_i/100
        invoice_item.invoice_id = row['invoice_id']
        invoice_item.item_id = row['item_id']
      end
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end
end