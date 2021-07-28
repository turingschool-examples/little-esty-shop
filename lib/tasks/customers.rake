require 'csv'

namespace :csv_load do
  desc "Load Customer CSV"
  task customers: :environment do
    # Customer.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!(:customers)
    csv_path = 'db/data/customers.csv'
    csv = CSV.open(csv_path, headers: true)
    csv.each do |row|
      Customer.create!(first_name: row['first_name'], last_name: row['last_name'])
    end
  end
end
