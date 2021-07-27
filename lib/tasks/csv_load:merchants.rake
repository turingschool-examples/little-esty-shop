require 'csv'

namespace :csv_load do
  desc "Imports Merchant CSV file into an ActiveRecord table"
  task :merchants => :environment do
      file = './db/data/merchants.csv'
      CSV.foreach(file, :headers => true) do |row|
        Merchant.create!({
                          :name => row[1],
                          :created_at => row[2],
                          :updated_at => row[3]
                          })
      end
  end
end
