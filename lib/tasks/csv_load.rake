require 'csv'

namespace :csv_load do

  desc 'seed data from Customers.csv'

  task customers: :environment do
    require './app/models/customer.rb'
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end
end
