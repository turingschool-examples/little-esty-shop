
require 'csv'

namespace :csv_fake do

  desc "Import customers from CSV"
  task customers: :environment do
    filename = File.join Rails.root, "/db/data/customers.csv"
    CSV.foreach(filename, :headers => true).take(40).each do |row|
      # row.delete(0)
      Customer.create!(row.to_h)
    end
  end

  desc "Import invoice_items from CSV"
  task invoice_items: :environment do
    filename = File.join Rails.root, "/db/data/fake_invoice_items.csv"
    CSV.foreach(filename, :headers => true).take(39).each do |row|
      # row.delete(0)
      InvoiceItem.create!(row.to_h)
    end
  end

  desc "Import invoices from CSV"
  task invoices: :environment do
    filename = File.join Rails.root, "/db/data/invoices.csv"
    CSV.foreach(filename, :headers => true).take(40).each do |row|
      # row.delete(0)
      Invoice.create!(row.to_h)
    end
  end

  desc "Import items from CSV"
  task items: :environment do
    filename = File.join Rails.root, "/db/data/items.csv"
    CSV.foreach(filename, :headers => true).take(40).each do |row|
      # row.delete(0)
      Item.create!(row.to_h)
    end
  end

  desc "Import merchants from CSV"
  task merchants: :environment do
    filename = File.join Rails.root, "/db/data/merchants.csv"
    CSV.foreach(filename, :headers => true).take(40).each do |row|
      # row.delete(0)
      Merchant.create!(row.to_h)
    end
  end

  desc "Import transactions from CSV"
  task transactions: :environment do
    filename = File.join Rails.root, "/db/data/transactions.csv"
    CSV.foreach(filename, :headers => true).take(40).each do |row|
      # row.delete(0)
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
