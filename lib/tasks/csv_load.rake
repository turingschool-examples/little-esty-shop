require 'csv'
namespace :csv_load do
  desc 'Loads customers CSV'
  task :customers => :environment do
    csv_text = File.read('./db/data/customers.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Customer.create!(row.to_hash)
    end
  ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  desc 'Loads merchants CSV'
  task :merchants => :environment do
    csv_text = File.read('./db/data/merchants.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Merchant.create!(row.to_hash)
    end
  ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  desc 'Loads invoices CSV'
  task :invoices => :environment do
    csv_text = File.read('./db/data/invoices.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Invoice.create!(row.to_hash)
    end
  ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  desc 'Loads transactions CSV'
  task :transactions => :environment do
    csv_text = File.read('./db/data/transactions.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Transaction.create!(row.to_hash)
    end
  ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  desc 'Loads items CSV'
  task :items => :environment do
    csv_text = File.read('./db/data/items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Item.create!(row.to_hash)
    end
  ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  desc 'Loads invoice_items CSV'
  task :invoice_items => :environment do
    csv_text = File.read('./db/data/invoice_items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      InvoiceItem.create!(row.to_hash)
    end
  ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end
end