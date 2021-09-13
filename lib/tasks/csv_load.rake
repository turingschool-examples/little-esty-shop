require 'csv'

namespace :csv_load do

  desc "Run All"
  task all: [:reset_pks, :customers, :invoices, :merchants, :transactions, :items, :invoice_items]

  desc "Load CSV for Customers"
  task customers: :environment do
    Customer.destroy_all
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_hash)
    end
    puts "Customers Imported"
  end

  desc "Load CSV for Invoices"
  task invoices: :environment do
    Invoice.destroy_all
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
    puts "Invoices Imported"
  end

  desc "Load CSV for Merchants"
  task merchants: :environment do
    Merchant.destroy_all
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
    puts "Merchants Imported"
  end

  desc "Load CSV for Transactions"
  task transactions: :environment do
    Transaction.destroy_all
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
    puts "Transactions Imported"
  end

  desc "Load CSV for IItems"
  task items: :environment do
    Item.destroy_all
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_hash)
    end
    puts "Items Imported"
  end

  desc "Load CSV for Invoice Items"
  task invoice_items: :environment do
    InvoiceItem.destroy_all
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
    puts "Invoice Items Imported"
  end

  desc "Reset all Primary Keys"
  task reset_pks: :environment do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end
end
