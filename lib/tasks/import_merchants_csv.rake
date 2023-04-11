require 'csv'

namespace :csv_load do
  desc "Import merchants from csv file"
  task :merchants => :environment do
    CSV.foreach("db/data/merchants.csv", headers: true) do |row|
      Merchant.find_or_create_by!(id: row['id']) do |merchant|
        merchant.name = row['name']
      end
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end
end