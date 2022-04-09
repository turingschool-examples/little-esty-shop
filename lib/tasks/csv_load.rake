require 'csv'

namespace :csv_load do
  desc 'seed data from Customers.csv'
  task customers: :environment do
    Customer.destroy_all
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  desc 'seed date from Merchants.csv'
  task merchants: :environment do
    Merchant.destroy_all
    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
      merchant.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  desc 'seed date from Items.csv'
  task items: :environment do
    Item.destroy_all
    CSV.foreach('db/data/items.csv', headers: true) do |row|
      row_hash = row.to_h
      merchant = Merchant.find(row_hash["merchant_id"])
      merchant.items.create!(row_hash)
    end
  ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end


  desc 'seed data from Invoice.csv'
  task invoices: :environment do
    Invoice.destroy_all
    CSV.foreach('db/data/invoices.csv', headers: true) do |row|
      customer = Customer.find(row.to_h["customer_id"])
      customer.invoice.create!(row.to_h)
    end
  ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  desc 'seed data from Transactions.csv'
  task transactions: :environment do
    Transaction.destroy_all
    CSV.foreach('db/data/transactions.csv', headers: true) do |row|
      invoice = Invoice.find(row.to_h["invoice_id"])
      invoice.transaction.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end
end
