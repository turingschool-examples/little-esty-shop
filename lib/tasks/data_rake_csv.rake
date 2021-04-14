require "csv"

namespace :csv_load do
  desc "Seed data.csv from db/data to database table"
  task merchants: :environment do
    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
      Merchant.create(row.to_h)
    end
    puts("Merchants imported")
  end

  task customers: :environment do
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create(row.to_h)
    end
    puts("Customers imported")
  end

  task invoice_items: :environment do
    CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create(row.to_h)
    end
    puts("Invoice Items imported")
  end

  task invoices: :environment do
    CSV.foreach('db/data/invoices.csv', headers: true) do |row|
      Invoice.create(row.to_h)
    end
    puts("Invoice imported")
  end

  task items: :environment do
    CSV.foreach('db/data/items.csv', headers: true) do |row|
      Item.create(row.to_h)
    end
    puts("Items imported")
  end

  task transactions: :environment do
    CSV.foreach('db/data/transactions.csv', headers: true) do |row|
      Transaction.create(row.to_h)
    end
    puts("Transaction imported")
  end


  task all: :environment do
    Rake::Task['csv_load:merchants'].execute
    Rake::Task['csv_load:items'].execute
    Rake::Task['csv_load:customers'].execute
    Rake::Task['csv_load:invoices'].execute
    Rake::Task['csv_load:invoice_items'].execute
    Rake::Task['csv_load:transactions'].execute
  end
end
