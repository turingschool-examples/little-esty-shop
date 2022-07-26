require 'CSV'

namespace :import do
    desc "import invoice data from CSV to database"
    task :invoices => :environment do
    CSV.foreach("db/data/invoices.csv", headers: true) do |row|
        Invoice.create!(row.to_hash)
        end
    end
end