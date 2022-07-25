require 'CSV'

namespace :import do
  desc "import customer data from CSV to database"
  task :customers => :environment do
    # CSV.foreach(Rails.root.join('customers.csv'), headers: true) do |row|
    CSV.foreach("db/data/customers.csv", headers: true) do |row|
      Customer.create!(row.to_hash)
    end
  end
end
