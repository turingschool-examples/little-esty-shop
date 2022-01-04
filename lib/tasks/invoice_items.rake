require 'csv'

namespace :csv_load do
  desc "load invoice items data"
  task invoice_items: :environment do
    CSV.foreach('db/data/invoice_items.csv', :headers => true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end
end
