require 'csv'

namespace :csv_load do 
  desc 'run all'
  task all: [:customers, :merchants, :items, :invoices, :invoice_items, :transactions]

  desc 'Load customer data'
  task customers: :environment do
    file_path = './db/data/customers.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|
      Customer.find_or_create_by!(line.to_hash)
    end
  end

  desc 'Load merchants data'
  task merchants: :environment do
    file_path = './db/data/merchants.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|
      Merchant.find_or_create_by!(line.to_hash)
    end
  end

  desc 'Load items data'
  task items: :environment do
    file_path = './db/data/items.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|
      Item.find_or_create_by!(line.to_hash)
    end
  end

  desc 'Load invoices data'
  task invoices: :environment do
    file_path = './db/data/invoices.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|
      Invoice.find_or_create_by!(line.to_hash)
    end
  end

  desc 'Load invoice_items data'
  task invoice_items: :environment do
    file_path = './db/data/invoice_items.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|
      InvoiceItem.find_or_create_by!(line.to_hash)
    end
  end

  desc 'Load transactions data'
  task transactions: :environment do
    file_path = './db/data/transactions.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|
      Transaction.find_or_create_by!(line.to_hash)
    end
  end
end
