require 'csv'

namespace :csv_load do
  desc 'Runs all CSV load tasks, including destruction of seed records and reset of pks for each table'
  task all: [:destroy_all, :create_customers, :create_merchants, :create_items, :create_invoices, :create_transactions, :create_invoice_items, :reset_all_pks]

  desc 'Destroy all - ordered by most to least dependent'
  task destroy_all: :environment do
    InvoiceItem.destroy_all
    Transaction.destroy_all
    Invoice.destroy_all
    Item.destroy_all
    Merchant.destroy_all
    Customer.destroy_all
  end

  desc 'Creates all customers - NOTE, should run the "all" task to destroy dependents and reset pks'
  task create_customers: :environment do
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_hash)
    end
  end

  desc 'Creates all merchants - NOTE, should run the "all" task to destroy dependents and reset pks'
  task create_merchants: :environment do
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  desc 'Creates all items - NOTE, should run the "all" task to destroy dependents and reset pks'
  task create_items: :environment do
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_hash)
    end
  end

  desc 'Creates all invoices - NOTE, should run the "all" task to destroy dependents and reset pks'
  task create_invoices: :environment do
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
  end

  desc 'Creates all transactions - NOTE, should run the "all" task to destroy dependents and reset pks'
  task create_transactions: :environment do
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
  end

  desc 'Creates all invoice items - NOTE, should run the "all" task to destroy dependents and reset pks'
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
