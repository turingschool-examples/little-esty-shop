require 'csv'

namespace :csv_load do
  desc "Import customer CSV Data in db"
  task customers: :environment do
    csv_text = File.read('db/data/customers.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Customer.create!(row.to_hash)
    end
  end

  desc "Import Invoice Items CSV data in db"
  task invoice_items: :environment do
    csv_text = File.read('db/data/invoice_items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  desc "Import Invoices CSV data in db"
  task invoices: :environment do
    csv_text = File.read('db/data/invoices.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Invoice.create!(row.to_hash)
    end
  end

  desc "Import Items CSV data in db"
  task items: :environment do
    csv_text = File.read('db/data/items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Item.create!(row.to_hash)
    end
  end

  desc "Import Merchants CSV data in db"
  task merchants: :environment do
    csv_text = File.read('db/data/merchants.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Merchant.create!(row.to_hash)
    end
  end

  desc "Import Transactions CSV data in db"
  task transactions: :environment do
    csv_text = File.read('db/data/transactions.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Transaction.create!(row.to_hash)
    end
  end

end
