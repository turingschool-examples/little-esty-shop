require 'csv'

namespace :csv_load do
  desc 'Run all CSV load tasks'
  task all: %i[destroy_all create_customers create_merchants create_items create_invoices create_transactions
               create_invoice_items reset_all_pks]

  desc 'Destroys all existing seed data, in order to properly seed new data'
  task destroy_all: :environment do
    InvoiceItem.destroy_all
    Transaction.destroy_all
    Item.destroy_all
    Invoice.destroy_all
    Merchant.destroy_all
    Customer.destroy_all
    puts 'All seeds destroyed'
  end

  desc 'Create all customers'
  task create_customers: :environment do
    Customer.destroy_all
    path = './db/data/customers.csv'
    CSV.foreach(path, headers: true) do |row|
      Customer.create!(row.to_hash)
    end
    # ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    puts "Inserted #{Customer.all.count} Customers"
  end

  desc 'Create all invoice items'
  task create_invoice_items: :environment do
    path = './db/data/invoice_items.csv'
    CSV.foreach(path, headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
    puts "Inserted #{InvoiceItem.all.count} Invoice Items"
  end

  desc 'Create all invoices'
  task create_invoices: :environment do
    path = './db/data/invoices.csv'
    CSV.foreach(path, headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
    puts "Inserted #{Invoice.all.count} Invoices"
  end

  desc 'Create all items'
  task create_items: :environment do
    path = './db/data/items.csv'
    CSV.foreach(path, headers: true) do |row|
      Item.create!(row.to_hash)
    end
    puts "Inserted #{Item.all.count} Items"
  end

  desc 'Create all merchants'
  task create_merchants: :environment do
    path = './db/data/merchants.csv'
    CSV.foreach(path, headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
    puts "Inserted #{Merchant.all.count} Merchants"
  end

  desc 'Create all transactions'
  task create_transactions: :environment do
    path = './db/data/transactions.csv'
    CSV.foreach(path, headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
    puts "Inserted #{Transaction.all.count} Transactions"
  end

  desc 'Resets all primary key autoincrement sequences for each table'
  task reset_all_pks: :environment do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
    puts 'Reset primary key autoincrement sequences for all tables'
  end
end
# rails csv_load:customers
# rails csv_load:invoice_items
# rails csv_load:invoices
# rails csv_load:items
# rails csv_load:merchants
# rails csv_load:transactions
