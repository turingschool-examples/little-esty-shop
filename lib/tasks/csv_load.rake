require 'csv'

namespace :csv_load do
  desc "Import merchants from csv file"

  task merchants: :environment do
    Merchant.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')

    file = "db/data/merchants.csv"

    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  desc "Import invoice items from csv file"

  task invoice_items: :environment do
    InvoiceItem.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')

    file = "db/data/invoice_items.csv"

    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  desc "Import items from csv file"

  task items: :environment do
    Item.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('items')

    file = "db/data/items.csv"

    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Item.create!(row.to_hash)
    end
  end

  desc "Import invoices from csv file"

  task invoices: :environment do
    Invoice.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')

    file = "db/data/invoices.csv"

    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      if row[:status] == "in progress"
        row[:status] = "in_progress"
      end

      Invoice.create!(row.to_hash)
    end
  end

  desc "Import transactions from csv file"

  task transactions: :environment do
    Transaction.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')

    file = "db/data/transactions.csv"

    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Transaction.create!(row.to_hash)
    end
  end

  desc "Import customers from csv file"

  task customers: :environment do
    Customer.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')

    file = "db/data/customers.csv"

    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Customer.create!(row.to_hash)
    end
  end

  desc "Import all csv files"

  task all: :environment do
    tasks = [ 'csv_load:merchants',
              'csv_load:items',
              'csv_load:customers',
              'csv_load:invoices',
              'csv_load:transactions',
              'csv_load:invoice_items']

    tasks.each do |task|
      Rake::Task[task].execute
    end
  end
end
