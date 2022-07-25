require 'csv'
namespace :csv_load do
  desc "imports customers from a csv file"
  task customers: :environment do
    CSV.foreach('db/data/customers.csv') do |row|
      first_name = row[0]
      last_name = row[1]
      Customer.create(first_name: first_name, last_name: last_name)
      p row
    end
  end
end
