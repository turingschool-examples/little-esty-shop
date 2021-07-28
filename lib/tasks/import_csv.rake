require 'csv'

namespace :csv_load do

  task customers: :environment do
    Customer.destroy_all
    file_path = "db/data/customers.csv"
    CSV.foreach(file_path, {headers: true, header_converters: :symbol}) do |row|
      Customer.create!(row.to_hash)
    end
  end

  task invoice_items: :environment do
    InvoiceItem.destroy_all
    file_path = "db/data/invoice_items.csv"
    CSV.foreach(file_path, {headers: true, header_converters: :symbol}) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  task invoices: :environment do
    Invoice.destroy_all
    file_path = "db/data/invoices.csv"
    CSV.foreach(file_path, {headers: true, header_converters: :symbol}) do |row|
      Invoice.create!(row.to_hash)
    end
  end

  task items: :environment do
    Item.destroy_all
    file_path = "db/data/items.csv"
    CSV.foreach(file_path, {headers: true, header_converters: :symbol}) do |row|
      Item.create!(row.to_hash)
    end
  end

  task merchants: :environment do
    Merchant.destroy_all
    file_path = "db/data/merchants.csv"
    CSV.foreach(file_path, {headers: true, header_converters: :symbol}) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  task transactions: :environment do
    Transaction.destroy_all
    file_path = "db/data/transactions.csv"
    CSV.foreach(file_path, {headers: true, header_converters: :symbol}) do |row|
      Transaction.create!(row.to_hash)
    end
  end

  task all: :environment do
    Rake::Task["csv_load:customers"].invoke
    Rake::Task["csv_load:invoice_items"].invoke
    Rake::Task["csv_load:invoices"].invoke
    Rake::Task["csv_load:items"].invoke
    Rake::Task["csv_load:merchants"].invoke
    Rake::Task["csv_load:transactions"].invoke
  end
end
