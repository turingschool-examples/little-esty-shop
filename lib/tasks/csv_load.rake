require 'csv'

namespace :csv_load do
  desc "imports merchants from csv file"
  task :merchants => :environment do
    merchant_csv_data = CSV.foreach('db/data/merchants.csv', headers: true).map do |row|
      Merchant.create!(name: row['name'], created_at: row['created_at'], updated_at: row['updated_at'], uuid: row['id'])
    end
  end

  desc "imports customers from csv file"
  task :customers => :environment do
    customer_csv_data = CSV.foreach('db/data/customers.csv', headers: true).map do |row|
      Customer.create!(first_name: row['first_name'], last_name: row['last_name'], created_at: row['created_at'], updated_at: row['updated_at'], uuid: row['id'])
    end
  end
end
