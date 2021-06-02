require 'csv'


namespace :csv_load do
  desc 'importing customers from csv file'
    task customers: :environment do
      Customer.destroy_all
      CSV.foreach("db/data/customers.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Customer.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    end

  desc 'importing invoice items from csv file'
    task invoice_items: :environment do
      InvoiceItem.destroy_all
      CSV.foreach("db/data/invoice_items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        InvoiceItem.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    end

  desc 'importing invoices from csv file'
    task invoices: :environment do
      Invoice.destroy_all
      CSV.foreach("db/data/invoices.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Invoice.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    end

  desc 'importing items from csv file'
    task items: :environment do
      Item.destroy_all
      CSV.foreach("db/data/items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Item.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('items')
    end

  desc 'importing merchants from csv file'
    task merchants: :environment do
      Merchant.destroy_all
      CSV.foreach("db/data/merchants.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Merchant.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    end

  desc 'importing transactions from csv file'
    task transactions: :environment do
      Transaction.destroy_all
      CSV.foreach("db/data/transactions.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Transaction.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    end

  desc 'importing all of the csv files'
    task all: :environment do
      Customer.destroy_all
      InvoiceItem.destroy_all
      Invoice.destroy_all
      Item.destroy_all
      Merchant.destroy_all
      Transaction.destroy_all

      CSV.foreach("db/data/merchants.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Merchant.create!(row.to_hash)
      end

      CSV.foreach("db/data/customers.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Customer.create!(row.to_hash)
      end

      CSV.foreach("db/data/invoices.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Invoice.create!(row.to_hash)
      end

      CSV.foreach("db/data/items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Item.create!(row.to_hash)
      end

      CSV.foreach("db/data/transactions.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Transaction.create!(row.to_hash)
      end

      CSV.foreach("db/data/invoice_items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        InvoiceItem.create!(row.to_hash)
      end

      ActiveRecord::Base.connection.reset_pk_sequence!('all')
  end
end
