require 'csv'

namespace :csv_load do
  desc "Import customers from csv file"
  task :customers => :environment do
    CSV.foreach("db/data/customers.csv", headers: true) do |row|
      Customer.find_or_create_by!(id: row['id']) do |customer|
        customer.first_name = row['first_name']
        customer.last_name = row['last_name']
      end
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end
end