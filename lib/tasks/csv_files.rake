require 'csv'

namespace :csv_load do
  desc "load all csv data"
  task all: [:customers, :invoices, :merchants, :items, :invoice_items, :transactions] do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end

  desc "load customers data"
  task customers: :environment do
    CSV.foreach('db/data/customers.csv', :headers => true) do |row|
      Customer.create!(row.to_hash)
    end
  end

  desc "load invoices data"
  task invoices: :environment do
    CSV.foreach('db/data/invoices.csv', :headers => true) do |row|
      Invoice.create!(row.to_hash)
    end
  end

  desc "load merchants data"
  task merchants: :environment do
    CSV.foreach('db/data/merchants.csv', :headers => true) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  desc "load items data"
  task items: :environment do
    CSV.foreach('db/data/items.csv', :headers => true) do |row|
      Item.create!(row.to_hash)
    end
  end

  desc "load invoice items data"
  task invoice_items: :environment do
    CSV.foreach('db/data/invoice_items.csv', :headers => true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  desc "load transactions data"
  task transactions: :environment do
    CSV.foreach('db/data/transactions.csv', :headers => true) do |row|
      Transaction.create!(row.to_hash)
    end
  end
end
