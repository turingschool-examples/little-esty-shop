require 'csv'

namespace :csv_load do
  desc "load items data"
  task items: :environment do
    CSV.foreach('db/data/items.csv', :headers => true) do |row|
      Item.create!(row.to_hash)
    end
  end
end
