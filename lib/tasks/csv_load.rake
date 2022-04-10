require 'csv'

def create_from_csv(klass, filename)
  klass.destroy_all
  rows = []
  CSV.foreach("db/data/#{filename}.csv", headers: true) do |row|
   rows << row.to_h
  end
  klass.create!(rows)
  ActiveRecord::Base.connection.reset_pk_sequence!(filename)
end

namespace :csv_load do

  desc 'seed data from customers.csv'
  task customers: :environment do
    create_from_csv(Customer, 'customers')
  end

  desc 'seed data from merchants.csv'
  task merchants: :environment do
    create_from_csv(Merchant, 'merchants')
  end

  desc 'seed data from items.csv'
  task items: :environment do
    create_from_csv(Item, 'items')
  end

  desc 'seed data from invoices.csv'
  task invoices: :environment do
    create_from_csv(Invoice, 'invoices')
  end

  desc 'seed data from invoice_items.csv'
  task invoice_items: :environment do
    create_from_csv(InvoiceItem, 'invoice_items')
  end

  desc 'seed data from transactions.csv'
  task transactions: :environment do
    create_from_csv(Transaction, 'transactions')
  end

  desc 'seed all data from all csvs'
  task all: [:customers, :merchants, :items, :invoices, :invoice_items, :transactions]
end
