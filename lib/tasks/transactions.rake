require 'csv'

namespace :csv_load do
  task transactions: :environment do
    CSV.foreach("db/data/transactions.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
      Transaction.create(row.to_hash)
    end
  end
end
