require 'csv'

namespace :csv_load do

  desc 'seed data from customers.csv'
  task customers: :environment do
    Customer.destroy_all
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  desc 'seed data from merchants.csv'
  task merchants: :environment do
    Merchant.destroy_all
    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  desc 'seed data from items.csv'
  task items: :environment do
    Item.destroy_all
    CSV.foreach('db/data/items.csv', headers: true) do |row|
      merchant = Merchant.find(row.to_h["merchant_id"])
      merchant.items.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  desc 'seed data from invoices.csv'
  task invoices: :environment do
    Invoice.destroy_all
    CSV.foreach('db/data/invoices.csv', headers: true) do |row|
      customer = Customer.find(row.to_h["customer_id"])
      customer.invoices.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  desc 'seed data from invoice_items.csv'
  task invoice_items: :environment do
    InvoiceItem.destroy_all
    CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  desc 'seed data from transactions.csv'
  task transactions: :environment do
    Transaction.destroy_all
    CSV.foreach('db/data/transactions.csv', headers: true) do |row|
      invoice = Invoice.find(row.to_h["invoice_id"])
      invoice.transactions.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end
end
