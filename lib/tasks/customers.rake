require 'csv'

namespace :csv_load do
  
  desc "Read CSV File Customers"
  task customers: :environment do
    customers = Rails.root.join("db", "data", "customers.csv")

    CSV.foreach(customers, headers: true) do |customer|
      Customer.create!(customer.to_hash)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end
end