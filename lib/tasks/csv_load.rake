require 'csv'

namespace :csv_load do 
  task customers: :environment do 
    CSV.foreach('./db/data/customers.csv', :headers => true) do |row|
      Customer.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end 
end 