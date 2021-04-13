require 'csv'

namespace :csv_load do

  desc "Seed db with csv customers"
  task customers: :environment do
    Customer.destroy_all
    CSV.foreach('./db/data/customers.csv', headers: true, header_converters: :symbol) do |row|
      binding.pry
      Customer.create!(row.to_hash)
    end
  end

  desc "Seed db with csv invoice_items"
  task invoices: :environment do
    InvoiceItem.destroy_all
    CSV.foreach('./db/data/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
      binding.pry
      InvoiceItem.create!(row.to_hash)
    end

  end

  desc "Seed db with csv invoices"
  task items: :environment do
    Invoice.destroy_all
    CSV.foreach('./db/data/invoices.csv', headers: true, header_converters: :symbol) do |row|
      binding.pry
      Invoice.create!(row.to_hash)
  end

  desc "Seed db with csv items"
  task merchants: :environment do
    Item.destroy_all
    CSV.foreach('./db/data/items.csv', headers: true, header_converters: :symbol) do |row|
      binding.pry
      Item.create!(row.to_hash)
  end

  desc "Seed db with csv merchants"
  task transactions: :environment do
    Merchant.destroy_all
    CSV.foreach('./db/data/merchants.csv', headers: true, header_converters: :symbol) do |row|
      binding.pry
      Merchant.create!(row.to_hash)
  end

  desc "Seed db with csv transactions"
  task invoice_items: :environment do
    Transaction.destroy_all
    CSV.foreach('./db/data/transactions.csv', headers: true, header_converters: :symbol) do |row|
      binding.pry
      Transaction.create!(row.to_hash)
  end
end
