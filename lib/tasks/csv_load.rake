require 'csv'

namespace :csv_load do
  desc "imports customer data from CSV and creates Customer objects"
  task customers: :environment do
    file = "db/data/customers.csv"
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      details = row.to_hash
      Customer.create!(details)
    end
  end

  desc "imports merchant data from CSV and creates Merchant objects"
  task merchants: :environment do
    file = "db/data/merchants.csv"
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      details = row.to_hash
      Merchant.create!(details)
    end
  end

  desc "imports item data from CSV and creates Item objects"
  task items: :environment do
    file = "db/data/items.csv"
    CSV.foreach(file, headers: ['id', 'name', 'description', 'sell_price',
                                'merchant_id', 'created_at', 'updated_at'],
                header_converters: :symbol) do |row|
      details = row.to_hash
      Item.create!(details)
    end
  end

  desc "imports invoice data from CSV and creates Invoice objects"
  task invoices: :environment do
    file = "db/data/invoices.csv"
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      details = row.to_hash
      # need to handle status column values here?
      Invoice.create!(details)
    end
  end

  desc "imports invoice_item data from CSV and creates Invoice_Item objects"
  task invoice_items: :environment do
    file = "db/data/invoice_items.csv"
    CSV.foreach(file, headers: ['id', 'item_id', 'invoice_id', 'quantity', 'sold_price', 'status',
                                'created_at', 'updated_at'],
                      header_converters: :symbol) do |row|
      details = row.to_hash
      # need to handle status column values here?
      InvoiceItem.create!(details)
    end
  end

  desc "imports transaction data from CSV and creates Transaction objects"
  task transactions: :environment do
    file = "db/data/transactions.csv"
    CSV.foreach(file, headers: ['id', 'invoice_id', 'credit_card_number', 'expiration_date', 'success',
                                'created_at', 'updated_at'],
                      header_converters: :symbol) do |row|
      details = row.to_hash
      # need to handle success boolean values here?
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
  end
end
