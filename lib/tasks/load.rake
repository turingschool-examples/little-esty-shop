require 'csv'
namespace :csv_load do

  task :customers => :environment do
      csv_text = File.read('db/data/customers.csv')
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        Customer.create!(row.to_hash)
    end
  end

  task :merchants => :environment do
    csv_text = File.read('db/data/merchants.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Merchant.create!(row.to_hash)
    end
  end

  task :invoices => :environment do
    csv_text = File.read('db/data/invoices.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Invoice.create!(row.to_hash)
    end
  end

  task :items => :environment do
    csv_text = File.read('db/data/items.csv')
    csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
      Item.create!(row.to_hash)
    end
  end

  task :transactions => :environment do
    csv_text = File.read('db/data/transactions.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Transaction.create!(row.to_hash)
    end
  end

  task :invoice_items => :environment do
    csv_text = File.read('db/data/invoice_items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  task :all => :environment do
    Rake::Task['csv_load:customers'].execute
    Rake::Task['csv_load:merchants'].execute
    Rake::Task['csv_load:items'].execute
    Rake::Task['csv_load:invoices'].execute
    Rake::Task['csv_load:transactions'].execute
    Rake::Task['csv_load:invoice_items'].execute
    end
    ActiveRecord::Base.connection.tables.each do |table_name|
  ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
end
end
