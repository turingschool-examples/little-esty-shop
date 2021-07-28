require 'csv'

namespace :csv_load do
  desc "Imports Merchant CSV file into an ActiveRecord table"
  task :merchants => :environment do
    Merchant.destroy_all
    file = './db/data/merchants.csv'
    CSV.foreach(file, :headers => true) do |row|
      Merchant.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:merchants)
  end
end
