require 'csv'
namespace :csv_load do

  desc "imports customers from a csv file"
  task customers: :environment do
    file = 'db/data/customers.csv'
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Customer.create(row.to_hash)
      p row
    end
  end

  desc "imports invoices from a csv file"
  task invoices: :environment do
    file = 'db/data/invoices.csv'
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Invoice.create(row.to_hash)
      p row
    end
  end

  desc "imports items from a csv file"
  task items: :environment do
    file = 'db/data/items.csv'
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Item.create(row.to_hash)
      p row
    end
  end

  desc "imports merchants from a csv file"
  task merchants: :environment do
    file = 'db/data/merchants.csv'
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Merchant.create(row.to_hash)
      p row
    end
  end

  desc "imports transactions from a csv file"
  task transactions: :environment do
    file = 'db/data/transactions.csv'
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Transaction.create(row.to_hash)
      p row
    end
  end

  desc "imports invoice_items from a csv file"
  task invoice_items: :environment do
    file = 'db/data/invoice_items.csv'
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create(row.to_hash)
      p row
    end
  end
end
