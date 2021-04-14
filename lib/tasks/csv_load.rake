require 'csv'

namespace :csv_load do
  desc "Loads merchants from csv file"


  task merchants: :environment do
     file = "./db/data/merchants.csv"

    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Merchant.find_or_create_by!(row.to_hash)
    end
  end

  task customers: :environment do
     file = "./db/data/customers.csv"

    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Customer.find_or_create_by!(row.to_hash)
    end
  end

  task invoices: :environment do
     file = "./db/data/invoices.csv"

    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Invoice.find_or_create_by!(row.to_hash)
    end
  end

  task items: :environment do
     file = "./db/data/items.csv"

    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Item.find_or_create_by!(row.to_hash)
    end
  end

  task invoice_items: :environment do
     file = "./db/data/invoice_items.csv"

    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      InvoiceItem.find_or_create_by!(row.to_hash)
    end
  end

  task transactions: :environment do
     file = "./db/data/transactions.csv"

    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Transaction.find_or_create_by!(row.to_hash)
    end
  end

  task all: :environment do
    Rake::Task['csv_load:merchants'].execute
    Rake::Task['csv_load:items'].execute
    Rake::Task['csv_load:customers'].execute
    Rake::Task['csv_load:invoices'].execute
    Rake::Task['csv_load:invoice_items'].execute
    Rake::Task['csv_load:transactions'].execute
  end
end
