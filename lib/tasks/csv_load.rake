require 'csv'

namespace :csv_load do
  desc "Seed db with all csv files"
  task all: [:customers, :merchants, :invoices, :items, :invoice_items, :transactions]

  desc "Seed db with csv customers"
  task customers: :environment do
    Customer.destroy_all
    CSV.foreach('./db/data/customers.csv', headers: true, header_converters: :symbol) do |row|
      Customer.create!(row.to_hash)
    end
  end

  desc "Seed db with csv invoice_items"
  task invoice_items: :environment do
    InvoiceItem.destroy_all
    CSV.foreach('./db/data/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  desc "Seed db with csv invoices"
  task invoices: :environment do
    Invoice.destroy_all
    CSV.foreach('./db/data/invoices.csv', headers: true, header_converters: :symbol) do |row|
      Invoice.create!(row.to_hash)
    end
  end

  desc "Seed db with csv items"
  task items: :environment do
    Item.destroy_all
    CSV.foreach('./db/data/items.csv', headers: true, header_converters: :symbol) do |row|
      Item.create!(row.to_hash)
    end
  end

  desc "Seed db with csv merchants"
  task merchants: :environment do
    Merchant.destroy_all
    CSV.foreach('./db/data/merchants.csv', headers: true, header_converters: :symbol) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  desc "Seed db with csv transactions"
  task transactions: :environment do
    Transaction.destroy_all
    CSV.foreach('./db/data/transactions.csv', headers: true, header_converters: :symbol) do |row|
      Transaction.create!(row.to_hash)
    end
  end
end
