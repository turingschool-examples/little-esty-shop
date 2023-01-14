require 'csv'

namespace :csv_load do

  # destroys all data before loading the fresh ones
  task destroy_all: :environment do
    InvoiceItem.destroy_all
    Transaction.destroy_all
    Invoice.destroy_all
    Item.destroy_all
    Discount.destroy_all
    Merchant.destroy_all
    Customer.destroy_all
  end

  # creates customers
  task customers: :environment do
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  # creates invoice_items
  task invoice_items: :environment do
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  # creates invoices
  task invoices: :environment do
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  # creates items
  task items: :environment do
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

    # creates merchants
  task merchants: :environment do
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  # creates transactions
  task transactions: :environment do
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  # creates discounts
  task discounts: :environment do
    CSV.foreach('./db/data/discounts.csv', headers: true) do |row|
      Discount.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('discounts')
  end

  # runs all previous tasks to seed fresh data
  task all: [:destroy_all, :customers, :merchants, :items, :invoices, :invoice_items, :transactions, :discounts]
end