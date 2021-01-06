require 'csv'
require 'rake'
namespace :csv_load do

    desc "load customers"
    task :customers => :environment do
        CSV.foreach("db/data/customers.csv", headers: true) do |row|
            Customer.create!(row.to_hash)
        end
    end

    desc "load merchants"
    task :merchants => :environment do
        CSV.foreach("db/data/merchants.csv", headers: true) do |row|
            Merchant.create!(row.to_hash)
        end
    end

    desc "load items"
    task :items => :environment do
        CSV.foreach("db/data/items.csv", headers: true) do |row|
            Item.create!(row.to_hash)
        end
    end

    desc "load invoices"
    task :invoices => :environment do
        CSV.foreach("db/data/invoices.csv", headers: true) do |row|
            Invoice.create!(row.to_hash)
        end
    end

    desc "load invoice_items"
     task :invoice_items => :environment do
        CSV.foreach("db/data/invoice_items.csv", headers: true) do |row|
            InvoiceItem.create!(row.to_hash)
        end
    end

    desc "load transactions"
    task :transactions => :environment do
        CSV.foreach("db/data/transactions.csv", headers: true) do |row|
            Transaction.create!(row.to_hash)
        end
    end

    desc "load all"
    task all: [ :customers, :merchants, :items, :invoices, :invoice_items, :transactions]    

end