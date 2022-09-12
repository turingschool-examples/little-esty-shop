require 'csv'

namespace :csv_load do
  desc "Load customers CSV into DB"
  task customers: :environment do
    CSV.foreach(Rails.root.join('db/data/customers.csv'), headers: true) do |row|
      Customer.create!({})
    end
  end

  desc "Load invoice_items CSV into DB"
  task invoice_items: :environment do
    CSV.foreach(Rails.root.join('db/data/invoice_items.csv'), headers: true) do |row|
      InvoiceItem.create!({})
    end
  end

  desc "Load invoices CSV into DB"
  task invoices: :environment do
    CSV.foreach(Rails.root.join('db/data/invoices.csv'), headers: true) do |row|
      Invoice.create!({})
    end
  end

  desc "Load items CSV into DB"
  task items: :environment do
    CSV.foreach(Rails.root.join('db/data/items.csv'), headers: true) do |row|
      Item.create!({})
    end
  end

  desc "Load merchants CSV into DB"
  task merchants: :environment do
    CSV.foreach(Rails.root.join('db/data/merchants.csv'), headers: true) do |row|
      Merchant.create!({})
    end
  end

  desc "Load transactions CSV into DB"
  task transactions: :environment do
    CSV.foreach(Rails.root.join('db/data/transactions.csv'), headers: true) do |row|
      Transaction.create!({})
    end
  end

  # desc "Loads all CSV into DB"
  # task all: :environment do
  #
  # end
end
