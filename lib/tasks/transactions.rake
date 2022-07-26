require 'CSV'

namespace :import do
    desc "import transaction data from CSV to database"
    task :transactions => :environment do
    CSV.foreach("db/data/transactions.csv", headers: true) do |row|
        Transaction.create!(row.to_hash)
        end
    end
end