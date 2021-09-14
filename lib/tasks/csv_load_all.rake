require "csv"

namespace :csv_load do

  desc "Load every csv"
  task all: [:customers, :merchants, :items, :invoices, :transactions, :invoice_items, :reset_pk] do
  end

    desc "Load customers csv"
    task customers: :environment do
      Customer.destroy_all

      CSV.foreach('./db/data/customers.csv', headers: true) do |row|
        Customer.create!(row.to_hash)
      end

      puts 'Customer data is now loaded'
    end

    desc "Load merchant csv"
    task merchants: :environment do
      Merchant.destroy_all

      CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
        Merchant.create!(row.to_hash)
      end

      puts 'Merchant info is now loaded'
    end

    desc "Load items csv"
    task items: :environment do
      Item.destroy_all

      CSV.foreach('./db/data/items.csv', headers: true) do |row|
        Item.create!(row.to_hash)
      end

      puts 'Item data is now loaded'
    end

    desc "Load invoices csv"
    task invoices: :environment do
      Invoice.destroy_all

      CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
        Invoice.create!(row.to_hash)
      end

      puts 'Invoice data now loaded'
    end

    desc "Load transaction csv"
    task transactions: :environment do
      Transaction.destroy_all

      CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
        Transaction.create!(row.to_hash)
      end

      puts 'Transaction info is now loaded'
    end

    desc "Load invoice items csv"
    task invoice_items: :environment do
      InvoiceItem.destroy_all

      CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
        InvoiceItem.create!(row.to_hash)
      end

      puts 'Invoice items is now loaded'
    end

    desc "Reset all primary keys"
    task reset_pk: :environment do
      ActiveRecord::Base.connection.tables.each do |t|
        ActiveRecord::Base.connection.reset_pk_sequence!(t)
      end
      puts 'Keys have been reset'
    end
end
