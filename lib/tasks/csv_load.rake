require 'csv'

namespace :csv_load do
  desc "Seed customer csv file"
  task customers: :environment do
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_hash)
    end
  end

  desc "Seed invoices csv file"
  task invoices: :environment do
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
  end

  desc "Seed merchants csv file"
  task merchants: :environment do
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  desc "Seed transactions csv file"
  task transactions: :environment do
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
  end

  desc "Seed items csv file"
  task items: :environment do
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_hash)
    end
  end

  desc "Seed invoice_items csv file"
  task invoice_items: :environment do
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end
end
