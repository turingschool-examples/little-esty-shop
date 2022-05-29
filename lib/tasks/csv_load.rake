require 'csv'

namespace :csv_load do
  desc 'TODO'
  task customers: :environment do
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create(row.to_h)
    end
  end

  desc 'seed database from invoice_items.csv'
  task invoice_items: :environment do
    CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create(row.to_h)
    end
  end

  desc 'seed database from invoices.csv'
  task invoices: :environment do
    CSV.foreach('db/data/invoices.csv', headers: true) do |row|
      Invoice.create(row.to_h)
    end
  end

  desc 'seed database from items.csv'
  task items: :environment do
    CSV.foreach('db/data/items.csv', headers: true) do |row|
      Item.create(row.to_h)
    end
  end

  desc 'seed database from merchants.csv'
  task merchants: :environment do
    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
      Merchant.create(row.to_h)
    end
  end

  desc 'seed database from transactions.csv'
  task transactions: :environment do
    CSV.foreach('db/data/transactions.csv', headers: true) do |row|
      Transaction.create(row.to_h)
    end
  end

  desc 'seed from all csv files'
  task all: %i[customers merchants items invoices invoice_items transactions]
end
