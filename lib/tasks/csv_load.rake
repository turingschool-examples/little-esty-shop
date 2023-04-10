require 'csv'

namespace :csv_load do
  desc "Load Customers CSV data"
  task customers: :environment do
    file_path = Rails.root.join('db', 'data', 'customers.csv')
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Customer.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("customers")
    puts "Customers CSV data loaded"
  end

  desc "Load InvoiceItems CSV data"
  task invoice_items: :environment do
    file_path = Rails.root.join('db', 'data', 'invoice_items.csv')
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("invoice_items")
    puts "InvoiceItems CSV data loaded"
  end

  desc "Load Invoices CSV data"
  task invoices: :environment do
    file_path = Rails.root.join('db', 'data', 'invoices.csv')
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Invoice.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("invoices")
    puts "Invoices CSV data loaded"
  end

  desc "Load Items CSV data"
  task items: :environment do
    file_path = Rails.root.join('db', 'data', 'items.csv')
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Item.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("items")
    puts "Items CSV data loaded"
  end

  desc "Load Merchants CSV data"
  task merchants: :environment do
    file_path = Rails.root.join('db', 'data', 'merchants.csv')
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Merchant.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("merchants")
    puts "Merchants CSV data loaded"
  end

  desc "Load Transactions CSV data"
  task transactions: :environment do
    file_path = Rails.root.join('db', 'data', 'transactions.csv')
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Transaction.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("transactions")
    puts "Transactions CSV data loaded"
  end

  desc "Load all CSV data"
  task all: ["csv_load:customers", "csv_load:merchants", "csv_load:items", "csv_load:invoices", "csv_load:transactions", "csv_load:invoice_items"] do
    puts "All CSV data loaded"
  end
end
