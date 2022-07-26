require 'CSV'

namespace :import do
    desc "import merchant data from CSV to database"
    task :merchants => :environment do
    CSV.foreach("db/data/merchants.csv", headers: true) do |row|
        Merchant.create!(row.to_hash)
        end
    end
end