require 'csv'

namespace :csv_load do
    desc "import csv files"
    task :customers => :environment do
        CSV.foreach("db/data/customers.csv", headers: true) do |row|
            Customer.create(row.to_h)
        end
    end

    task :merchants => :environment do
        CSV.foreach("db/data/merchants.csv", headers: true) do |row|
            Merchant.create(row.to_h)
        end
    end
end
