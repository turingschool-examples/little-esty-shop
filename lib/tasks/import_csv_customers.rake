require 'csv'

task :import, [:customers] => :environment do
  CSV.foreach('db/data/customers.csv', headers: true) do |row|
    Customer.create!(row.to_hash)
  end
end
