require 'csv'

namespace :csv_load do
  desc "load merchants data"
  task merchants: :environment do
    CSV.foreach('db/data/merchants.csv', :headers => true) do |row|
      Merchant.create!(row.to_hash)
    end
  end
end
