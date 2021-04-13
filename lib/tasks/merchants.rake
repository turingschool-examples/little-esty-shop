require 'csv'

namespace :csv_load do

desc "Import merchants from CSV"
task merchants: :environment do
  CSV.foreach("db/data/merchants.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
    Merchant.create(row.to_hash)
    end
  end
end
