require 'csv'
require 'rake'

namespace :csv_load do
    desc "Create all customers"
    task customers: :environment do
        path = './db/data/customers.csv'

        CSV.foreach(path, :headers => true) do |row|
            Customer.create!(row.to_hash)
        end
        ActiveRecord::Base.connection.reset_pk_sequence!('customers')
        puts "Inserted #{Customer.all.count} Customers"
    end
end


# rails csv_load:customers
# rails csv_load:invoice_items
# rails csv_load:invoices
# rails csv_load:items
# rails csv_load:merchants
# rails csv_load:transactions
