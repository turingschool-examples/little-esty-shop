require 'csv'

namespace :csv_load do
  desc 'Run all CSV load tasks, including destruction of seed records and reset of pks for each table'
  task all: [:destroy_all, :create_customers, :create_merchants, :create_items, :create_discounts, :create_invoices, :create_transactions, :create_invoice_items, :reset_all_pks]

  desc 'Destroy all - ordered by most to least dependent'
  task destroy_all: :environment do
    InvoiceItem.destroy_all
    Transaction.destroy_all
    Invoice.destroy_all
    Item.destroy_all
    Discount.destroy_all
    Merchant.destroy_all
    Customer.destroy_all
    puts "All Seeds destroyed"
  end

  desc 'Create all Customers - NOTE, please run the ":all" task to destroy_all dependents and reset pks'
  task create_customers: :environment do
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_hash)
    end
    puts "All Customers successfully seeded"
  end

  desc 'Create all Merchants - NOTE, please run the ":all" task to destroy_all dependents and reset pks'
  task create_merchants: :environment do
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
    puts "All Merchants successfully seeded"
  end

  desc 'Create all Items - NOTE, please run the ":all" task to destroy_all dependents and reset pks'
  task create_items: :environment do
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_hash)
    end
    puts "All Items successfully seeded"
  end

  desc 'Create all Discounts - NOTE, please run the ":all" task to destroy_all dependents and reset pks'
  task create_discounts: :environment do
    CSV.foreach('./db/data/discounts.csv', headers: true) do |row|
      Discount.create!(row.to_hash)
    end
    puts "All Discounts successfully seeded"
  end

  desc 'Create all Invoices - NOTE, please run the ":all" task to destroy_all dependents and reset pks'
  task create_invoices: :environment do
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
    puts "All Invoices successfully seeded"
  end

  desc 'Create all Transactions - NOTE, please run the ":all" task to destroy_all dependents and reset pks'
  task create_transactions: :environment do
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
    puts "All Transactions successfully seeded"
  end

  desc 'Create all Invoice Items - NOTE, please run the ":all" task to destroy_all dependents and reset pks'
  task create_invoice_items: :environment do
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
    puts "All Invoice Items successfully seeded"
  end

  desc 'Reset all primary key autoincrement sequences'
  task reset_all_pks: :environment do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end
  puts "All Table primary keys successfully reset"
end
