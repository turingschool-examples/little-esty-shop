require 'csv'

namespace :csv_load do
  desc 'loads customer CSV into db'
	task :customers do
    # Specify file name/location
    file = 'db/data/customers.csv'
     
    # Create individual records by passing each row into a Customer instance
    CSV.foreach(file, headers: true) do |row|
      Customer.create!(row.to_hash)
    end

    # Makes it so rails starts new Customer instances after existing data id's
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
	end
end