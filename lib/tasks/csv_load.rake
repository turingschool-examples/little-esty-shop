require 'csv'
namespace :csv_load do

  desc "imports customers from a csv file"
  task customers: :environment do
    CSV.foreach('db/data/customers.csv') do |row|
      first_name = row[0]
      last_name = row[1]
      Customer.create(first_name: first_name, last_name: last_name)
      p row
    end
  end

  desc "imports invoices from a csv file"
  task invoices: :environment do
    CSV.foreach('db/data/invoices.csv') do |row|
      status = row[0]
      Invoice.create(status: status)
      p row
    end
  end

  desc "imports items from a csv file"
  task items: :environment do
    CSV.foreach('db/data/invoices.csv') do |row|
      name = row[0]
      description = row[1]
      unit_price = row[2]
      Item.create(name: name, description: description, unit_price: unit_price)
      p row
    end
  end

  desc "imports merchants from a csv file"
  task merchants: :environment do
    file = 'db/data/merchants.csv'
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Merchant.create(row.to_hash)
      p row
    end
  end

  desc "imports transactions from a csv file"
  task transactions: :environment do
    file = 'db/data/transactions.csv'
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Transaction.create(row.to_hash)
      p row
    end
  end

  desc "imports invoice_items from a csv file"
  task invoice_items: :environment do
    file = 'db/data/invoice_items.csv'
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create(row.to_hash)
      p row
    end
  end
end
