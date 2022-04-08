require 'csv'

namespace :csv_load do

  desc 'seed data from Customers.csv'

  task :customers do
    customers = []
    CSV.foreach('../db/data/customers.csv', headers: true) do |row|
      customers << row.to_h
    end
    Customer.import(customers)
  end
end
