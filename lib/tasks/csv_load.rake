require 'CSV'
require 'benchmark'

namespace :csv_load do
  desc 'importing customers from csv file'
  task customers: :environment do
    puts 'resetting database'
    Customer.destroy_all
    puts 'database successfully deleted'
    puts 'loading data...'
    time = Benchmark.realtime do
      CSV.foreach("db/data/customers.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Customer.create(row.to_hash)
      end
    end

    puts "Added #{Customer.count} customers in #{time} seconds"

    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end
  end
end
