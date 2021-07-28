require 'csv'

namespace :csv_load do
  desc "Load Invoice Items CSV"
  task invoice_items: :environment do
    # InvoiceItem.destroy_all
    csv_path = 'db/data/invoice_items.csv'
    csv = CSV.open(csv_path, headers: true)
    csv.each do |row|
      InvoiceItem.create!(item_id: row['item_id'], invoice_id: row['invoice_id'], quantity: row['quantity'], unit_price: row['unit_price'], status: row['status'])
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:invoice_items)
  end
end
