require 'csv'

namespace :csv_load do
  desc "Import merchants from csv file"

  task merchants: :environment do

    file = "db/data/merchants.csv"

    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Merchant.create!({
        name: row[:name],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
        })
    end
  end
end
