require 'csv'

namespace :csv_load do
  desc "Imports Customer CSV file into an ActiveRecord table"
  task :customers => :environment do
    Customer.destroy_all
    file = './db/data/customers.csv'
    CSV.foreach(file, :headers => true) do |row|
      Customer.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:customers)
  end
end
