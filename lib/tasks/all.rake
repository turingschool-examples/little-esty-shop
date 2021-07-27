require 'csv'

namespace :csv_load do
  desc 'all'
  task all: [:destroy_all, :create_customers, :create_merchants, :create_items, :create_invoices, :create_transactions, :create_invoice_items, :reset_all_pks]

  desc 'Destroy all'
  task destroy_all: :environment do
    InvoiceItem.destroy_all
    Transaction.destroy_all
    Invoice.destroy_all
    Item.destroy_all
    Merchant.destroy_all
    Customer.destroy_all
  end

  desc 'Create customers'
  task create_customers: :environment do
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_hash)
    end
  end

  desc 'Create merchants'
  task create_merchants: :environment do
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  desc 'Create items'
  task create_items: :environment do
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_hash)
    end
  end

  desc 'Create invoices'
  task create_invoices: :environment do
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
  end

  desc 'Create transactions'
  task create_transactions: :environment do
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
  end

  desc 'Create invoice items'
  task create_invoice_items: :environment do
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  desc 'Reset all primary key autoincrement sequences'
  task reset_all_pks: :environment do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end
end
