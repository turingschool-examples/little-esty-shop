require 'csv'

namespace :csv_load do

  desc 'seed data from all csv files'
  task all: :environment do
    #seeds customers
    Customer.destroy_all
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    #seeds merchants
    Merchant.destroy_all
    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    #seeds items
    Item.destroy_all
    CSV.foreach('db/data/items.csv', headers: true) do |row|
      merchant = Merchant.find(row.to_h["merchant_id"])
      merchant.items.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    #seeds invoices
    Invoice.destroy_all
    CSV.foreach('db/data/invoices.csv', headers: true) do |row|
      customer = Customer.find(row.to_h["customer_id"])
      customer.invoices.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    #seeds invoice items
    InvoiceItem.destroy_all
    CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    #seeds transactions
    Transaction.destroy_all
    CSV.foreach('db/data/transactions.csv', headers: true) do |row|
      invoice = Invoice.find(row.to_h["invoice_id"])
      invoice.transactions.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end
end
