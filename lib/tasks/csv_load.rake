require 'csv'


namespace :csv_load do
  desc "run all load tasks"
  task all: [:customers, :invoices, :transactions, :merchants, :items, :invoice_items]

  desc "Load customer data"
  task customers: :environment do
    file_path = './db/data/customers.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|
      Customer.create!(line.to_hash)
    end
  end

  desc "Load invoices data"
  task invoices: :environment do
    file_path = './db/data/invoices.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)
    data.each do |line|

      if line[:status] == "cancelled"
        line[:status] = 0
      elsif line[:status] == "in progress"
        line[:status] = 1
      elsif line[:status] == "completed"
        line[:status] = 2
      else
        line[:status] = 3
      end

      Invoice.create!(line.to_hash)
    end
  end

  desc "Load transaction data"
  task transactions: :environment do
    file_path = './db/data/transactions.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|
      Transaction.create!(line.to_hash)
    end
  end

  desc "Load merchants data"
  task merchants: :environment do
    file_path = './db/data/merchants.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|
      Merchant.create!(line.to_hash)
    end
  end

  desc "Load items data"
  task items: :environment do
    file_path = './db/data/items.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|
      Item.create!(line.to_hash)
    end
  end

  desc "Load invoice_items data"
  task invoice_items: :environment do
    file_path = './db/data/invoice_items.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|

      if line[:status] == "packaged"
        line[:status] = 0
      elsif line[:status] == "pending"
        line[:status] = 1
      elsif line[:status] == "shipped"
        line[:status] = 2
      else
        line[:status] = 3
      end

      InvoiceItem.create!(line.to_hash)
    end
  end
end
