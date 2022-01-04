namespace :csv_load do
  desc 'All'

  task all: [:create_customers, :create_merchants, :create_items, :create_invoices, :create_invoice_items, :create_transactions] do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end

  desc 'Create Customers'
  task create_customers: :environment do
    require 'csv'
    CSV.foreach('db/data/customers.csv', :headers => true) do |row|
      Customer.create!(row.to_hash)
    end
  end

  desc 'Create Items'
  task create_items: :environment do
    require 'csv'
    CSV.foreach('db/data/items.csv', :headers => true) do |row|
      Item.create!(row.to_hash)
    end
  end

  desc 'Create Invoices'
  task create_invoices: :environment do
    require 'csv'
    CSV.foreach('db/data/invoices.csv', :headers => true) do |row|
      Invoice.create!(row.to_hash)
    end
  end

  desc 'Create Merchants'
  task create_merchants: :environment do
    require 'csv'
    CSV.foreach('db/data/merchants.csv', :headers => true) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  desc 'Create Transactions'
  task create_transactions: :environment do
    require 'csv'
    CSV.foreach('db/data/transactions.csv', :headers => true) do |row|
      Transaction.create!(row.to_hash)
    end
  end

  desc 'Create Invoice Items'
  task create_invoice_items: :environment do
    require 'csv'
    CSV.foreach('db/data/invoice_items.csv', :headers => true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end
end
