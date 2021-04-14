require 'csv'

namespace :csv_load do
  desc "Loads merchants from csv file"


  task merchants: :environment do
     file = "./db/data/merchants.csv"

    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Merchant.create!(row.to_hash)
    end
  end
end
