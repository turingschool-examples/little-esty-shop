require 'csv'

namespace :csv_load do
  desc "load customers data"
  task customers: :environment do
    CSV.foreach('db/data/customers.csv', :headers => true) do |row|
      Customer.create!(row.to_hash)
    end
  end
end
