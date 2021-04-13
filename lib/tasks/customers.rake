require 'csv'

namespace :csv_load do

desc "Import customers from CSV"
task customers: :environment do
  CSV.foreach("db/data/customers.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
    Customer.create(row.to_hash)
    end
  end
end
