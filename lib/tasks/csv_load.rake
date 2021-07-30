require 'csv'
require './app/helpers/csv_load_helper'
include CsvLoadHelper

namespace :csv_load do

  desc 'Import customers from CSV'
  task customers: :environment do
    CSV.foreach("db/data/customers.csv", {headers: true, header_converters: :symbol}) do |row|
      csv_import(Customer, row)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  desc 'Import invoice_items from CSV'
  task invoice_items: :environment do
    CSV.foreach("db/data/invoice_items.csv", {headers: true, header_converters: :symbol}) do |row|
      csv_import(InvoiceItem, row)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  desc 'Import invoices from CSV'
  task invoices: :environment do
    CSV.foreach("db/data/invoices.csv", {headers: true, header_converters: :symbol}) do |row|
      csv_import(Invoice, row)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  desc 'Import items from CSV'
  task items: :environment do
    CSV.foreach("db/data/items.csv", {headers: true, header_converters: :symbol}) do |row|
      csv_import(Item, row)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  desc 'Import merchants from CSV'
  task merchants: :environment do
    CSV.foreach("db/data/merchants.csv", {headers: true, header_converters: :symbol}) do |row|
      csv_import(Merchant, row)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  desc 'Import transactions from CSV'
  task transactions: :environment do
    CSV.foreach("db/data/transactions.csv", {headers: true, header_converters: :symbol}) do |row|
      csv_import(Transaction, row)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  desc 'Import all CSV files at once'
  task all: [
    "csv_load:customers",
    "csv_load:merchants",
    "csv_load:items",
    "csv_load:invoices",
    "csv_load:invoice_items",
    "csv_load:transactions"
  ]
end
