require 'csv'

namespace :csv_load do
  desc "Import customers from csv file"
    task customers: :environment do
      file = "db/data/customers.csv"
      ActiveRecord::Base.connection.reset_pk_sequence!(:customers)
      CSV.foreach(file, headers: true) do |row|
        customer_hash = row.to_hash
        Customer.create!(customer_hash)
      end
    end

  desc "Import invoice_items from csv file"
    task invoice_items: :environment do
      file = "db/data/invoice_items.csv"
      ActiveRecord::Base.connection.reset_pk_sequence!(:invoice_items)
      CSV.foreach(file, headers: true) do |row|
        invoice_item_hash = row.to_hash
        InvoiceItem.create!(invoice_item_hash)
      end
    end

  desc "Import invoices from csv file"
    task invoices: :environment do
      file = "db/data/invoices.csv"
      ActiveRecord::Base.connection.reset_pk_sequence!(:invoices)
      CSV.foreach(file, headers: true) do |row|
        invoice_hash = row.to_hash
        Invoice.create!(invoice_hash)
      end
    end

  desc "Import items from csv file"
    task items: :environment do
      file = "db/data/items.csv"
      ActiveRecord::Base.connection.reset_pk_sequence!(:items)
      CSV.foreach(file, headers: true) do |row|
        item_hash = row.to_hash
        Item.create!(item_hash)
      end
    end

  desc "Import merchants from csv file"
    task merchants: :environment do
      file = "db/data/merchants.csv"
      ActiveRecord::Base.connection.reset_pk_sequence!(:merchants)
      CSV.foreach(file, headers: true) do |row|
        merchant_hash = row.to_hash
        Merchant.create!(merchant_hash)
      end
    end

  desc "Import transactions from csv file"
    task transactions: :environment do
      file = "db/data/transactions.csv"
      ActiveRecord::Base.connection.reset_pk_sequence!(:transactions)
      CSV.foreach(file, headers: true) do |row|
        transaction_hash = row.to_hash
        Transaction.create!(transaction_hash)
      end
    end

    task all: :environment do
      InvoiceItem.destroy_all
      Transaction.destroy_all
      Item.destroy_all
      Merchant.destroy_all
      Invoice.destroy_all
      Customer.destroy_all
      Rake::Task["csv_load:customers"].invoke
      Rake::Task["csv_load:invoices"].invoke
      Rake::Task["csv_load:merchants"].invoke
      Rake::Task["csv_load:items"].invoke
      Rake::Task["csv_load:transactions"].invoke
      Rake::Task["csv_load:invoice_items"].invoke
    end 
end




# rails csv_load:customers
# rails csv_load:invoice_items
# rails csv_load:invoices
# rails csv_load:items
# rails csv_load:merchants
# rails csv_load:transactions
