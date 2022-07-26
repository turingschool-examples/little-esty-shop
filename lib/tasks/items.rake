require 'CSV'

namespace :import do
    desc "import item data from CSV to database"
    task :items => :environment do
    CSV.foreach("db/data/items.csv", headers: true) do |row|
        Item.create!(row.to_hash)
        end
    end
end