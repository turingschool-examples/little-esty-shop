require 'csv'

namespace :csv_load do

desc "Import invoices from CSV"
task invoices: :environment do
  CSV.foreach("db/data/invoices.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
    Invoice.create(row.to_hash)
    end
  end
end
