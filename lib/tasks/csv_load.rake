require 'csv'

namespace :csv_load do
  desc "imports customer data from CSV and creates Customer objects"
  task customers: :environment do
    Customer.destroy_all
    file = "db/data/customers.csv"
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      details = row.to_hash
      Customer.create!(details)
    end
  end

  desc "imports merchant data from CSV and creates Merchant objects"
  task merchants: :environment do
    Merchant.destroy_all
    file = "db/data/merchants.csv"
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      details = row.to_hash
      Merchant.create!(details)
    end
  end

  desc "imports item data from CSV and creates Item objects"
  task items: :environment do
    Item.destroy_all
    file = "db/data/items.csv"
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      details = row.to_hash
      Item.create!(details)
    end
  end

  desc "imports invoice data from CSV and creates Invoice objects"
  task invoices: :environment do
    Invoice.destroy_all
    file = "db/data/invoices.csv"
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      details = row.to_hash
      details[:status] = convert_invoice_status(details[:status])
      Invoice.create!(details)
    end
  end

  desc "imports invoice_item data from CSV and creates Invoice_Item objects"
  task invoice_items: :environment do
    InvoiceItem.destroy_all
    file = "db/data/invoice_items.csv"
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      details = row.to_hash
      details[:status] = convert_invoice_item_status(details[:status])
      InvoiceItem.create!(details)
    end
  end

  desc "imports transaction data from CSV and creates Transaction objects"
  task transactions: :environment do
    Transaction.destroy_all
    file = "db/data/transactions.csv"
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      details = row.to_hash
      details[:result] = convert_transaction_result(details[:result])
      Transaction.create!(details)
    end
  end

  desc "imports all of the CSVs and creates records for all six tables"
  task all: :environment do
    Rake::Task["csv_load:customers"].execute
    Rake::Task["csv_load:merchants"].execute
    Rake::Task["csv_load:items"].execute
    Rake::Task["csv_load:invoices"].execute
    Rake::Task["csv_load:invoice_items"].execute
    Rake::Task["csv_load:transactions"].execute

    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end
end

def convert_transaction_result(result)
  case result
    when 'success' then true
    when 'failed' then false
  end
end

def convert_invoice_status(status)
  case status
    when 'in progress' then 0
    when 'completed' then 1
    when 'cancelled' then 2
  end
end

def convert_invoice_item_status(status)
  case status
    when 'pending' then 0
    when 'packaged' then 1
    when 'shipped' then 2
  end
end