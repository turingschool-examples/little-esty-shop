require 'csv'

namespace :csv_load do

desc "Import items from CSV"
task items: :environment do
  CSV.foreach("db/data/items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
    Item.create(row.to_hash)
    end
  end
end
