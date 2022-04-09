
require 'csv'

namespace :import do

  desc "Import customers from CSV"
  task customers: :environment do
    filename = File.join Rails.root, "/db/data/customers.csv"
    CSV.foreach(filename, :headers => true) do |row|
      Customer.create!(row.to_h)
    end
  end

  desc "Import invoice_items from CSV"
  task invoice_items: :environment do
    filename = File.join Rails.root, "/db/data/invoice_items.csv"
    CSV.foreach(filename, :headers => true) do |row|
      InvoiceItem.create!(row.to_h)
    end
  end

  desc "Import invoices from CSV"
  task invoices: :environment do
    filename = File.join Rails.root, "/db/data/invoices.csv"
    CSV.foreach(filename, :headers => true) do |row|
      Invoice.create!(row.to_h)
    end
  end

  desc "Import items from CSV"
  task items: :environment do
    filename = File.join Rails.root, "/db/data/items.csv"
    CSV.foreach(filename, :headers => true) do |row|
      Item.create!(row.to_h)
    end
  end

  desc "Import merchants from CSV"
  task merchants: :environment do
    filename = File.join Rails.root, "/db/data/merchants.csv"
    CSV.foreach(filename, :headers => true) do |row|
      Merchant.create!(row.to_h)
    end
  end

  desc "Import transactions from CSV"
  task transactions: :environment do
    filename = File.join Rails.root, "/db/data/transactions.csv"
    CSV.foreach(filename, :headers => true) do |row|
      Transaction.create!(row.to_h)
    end
  end

  # desc "Import all from CSV"
  # task all: :environment do
  #   filename = File.join Rails.root, "/db/data"
  #   CSV.foreach(filename, :headers => true) do |row|
  #     Transaction.create!(row.to_h)
  #   end
  # end
end
