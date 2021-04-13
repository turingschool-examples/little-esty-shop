require 'csv'

namespace :csv_load do

desc "Import invoice items from CSV"
task invoice_items: :environment do
  CSV.foreach("db/data/invoice_items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
    InvoiceItem.create(row.to_hash)
    end
  end
end
