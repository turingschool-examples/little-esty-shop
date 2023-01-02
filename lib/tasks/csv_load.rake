require_relative 'csv_parser.rb'
require 'csv'

namespace :csv_load do
  task :merchants => :environment do
    puts 'Loading Merchant Information!'
    Merchant.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end
  end

  task :items => :environment do
    puts 'Loading Item Information!'
    Item.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_h)
    end
  end

  task :invoices => :environment do
    puts 'Loading Invoice Information!'
    Invoice.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_h)
    end
  end

  task :invoice_items => :environment do
    puts 'Loading Invoice Item Information!'
    InvoiceItem.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end
  end

  task :transactions => :environment do
    puts 'Loading Transaction Information!'
    Transaction.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_h)
    end
  end

  task :customers => :environment do
    puts 'Loading Customer Information!'
    Customer.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end
  end

  task :all do
    Rake::Task['csv_load:merchants'].invoke
    Rake::Task['csv_load:items'].invoke
    Rake::Task['csv_load:customers'].invoke
    Rake::Task['csv_load:invoices'].invoke
    Rake::Task['csv_load:invoice_items'].invoke
    Rake::Task['csv_load:transactions'].invoke
  end
end
