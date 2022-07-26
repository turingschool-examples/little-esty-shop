require 'CSV'

namespace :import do
    desc "import invoice item data from CSV to database"
    task :invoice_items => :environment do
    CSV.foreach("db/data/invoice_items.csv", headers: true) do |row|
        InvoiceItem.create!(row.to_hash)
        end
    end
end
