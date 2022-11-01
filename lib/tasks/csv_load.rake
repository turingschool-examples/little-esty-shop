namespace :csv_load do
  require "csv"
  desc "TODO"

  task customers: :environment do
    csv_text = File.read(Rails.root.join("db", "data", "customers.csv"))
    csv = CSV.parse(csv_text, :headers => true)

    csv.each do |row|
      Customer.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    puts "."
  end

  task merchants: :environment do
    csv_text = File.read(Rails.root.join("db", "data", "merchants.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Merchant.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    puts ".."
  end

  task items: :environment do
    csv_text = File.read(Rails.root.join("db", "data", "items.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Item.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    puts "..."
  end

  task invoices: :environment do
    csv_text = File.read(Rails.root.join("db", "data", "invoices.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Invoice.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    puts "...."
  end

  task invoice_items: :environment do
    csv_text = File.read(Rails.root.join("db", "data", "invoice_items.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      InvoiceItem.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    puts "....."
  end

  task transactions: :environment do
    csv_text = File.read(Rails.root.join("db", "data", "transactions.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Transaction.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    puts "......"
  end

  task delete_all: :environment do
    InvoiceItem.destroy_all
    Item.destroy_all
    Merchant.destroy_all
    Transaction.destroy_all
    Invoice.destroy_all
    Customer.destroy_all
    puts "Destroying the evidence"
  end

  task all: [:customers, :merchants, :items, :invoices, :invoice_items, :transactions]

end
