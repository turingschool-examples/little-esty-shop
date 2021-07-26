require 'csv'

namespace :csv_load do
  desc "Imports a Customer CSV file into an ActiveRecord table"
  task :items => :environment do
      file = './db/data/items.csv'
      CSV.foreach(file, :headers => true) do |row|
        Item.create!({
                          :name => row[1],
                          :description => row[2],
                          :unit_price => row[3],
                          :merchant_id => row[4],
                          :created_at => row[5],
                          :updated_at => row[6]
                          })
      end
  end
end
