require 'csv'

namespace :csv_load do
  desc "load transactions data"
  task transactions: :environment do
    CSV.foreach('db/data/transactions.csv', :headers => true) do |row|
      Transaction.create!(row.to_hash)
    end
  end
end
