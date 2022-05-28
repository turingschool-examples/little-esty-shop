require 'csv'

namespace :csv_load do
  desc 'Transferring data from CSV to Database'
  task customers: :environment do
    Customer.destroy_all
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create(row.to_h)
    end
    # resets primary key sequence in rails based on current data
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  task invoices: :environment do
    Invoice.destroy_all
    CSV.foreach('db/data/invoices.csv', headers: true) do |row|
      Invoice.create(row.to_h)
    end
    # resets primary key sequence in rails based on current data
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  desc 'reset all table primary keys'
  task reset_keys: :environment do
    ActiveRecord::Base.connection.tables.each do |table_name|
      ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
    end
  end
end
