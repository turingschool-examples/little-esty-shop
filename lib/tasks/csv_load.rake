require 'csv'


namespace :csv_load do
  desc "run all load tasks"
  task all: [:destroy_all, :customers, :invoices, :transactions, :merchants, :items, :invoice_items]

  desc "destroy_all table items"
  task destroy_all: :environment do
    InvoiceItem.destroy_all
    Item.destroy_all
    Merchant.destroy_all
    Transaction.destroy_all
    Invoice.destroy_all
    Customer.destroy_all
  end

  desc "Load customer data"
  task customers: :environment do
    file_path = './db/data/customers.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|
      Customer.create!(line.to_hash)
    end

    ActiveRecord::Base.connection.execute(
      "ALTER SEQUENCE customers_id_seq RESTART WITH #{Customer.maximum(:id) + 1}"
    )
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

    ActiveRecord::Base.connection.execute(
      "ALTER SEQUENCE invoices_id_seq RESTART WITH #{Invoice.maximum(:id) + 1}"
    )
  end

  desc "Load transaction data"
  task transactions: :environment do
    file_path = './db/data/transactions.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|
      Transaction.create!(line.to_hash)
    end

    ActiveRecord::Base.connection.execute(
      "ALTER SEQUENCE transactions_id_seq RESTART WITH #{Transaction.maximum(:id) + 1}"
    )
  end

  desc "Load merchants data"
  task merchants: :environment do
    file_path = './db/data/merchants.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|
      Merchant.create!(line.to_hash)
    end

    ActiveRecord::Base.connection.execute(
      "ALTER SEQUENCE merchants_id_seq RESTART WITH #{Merchant.maximum(:id) + 1}"
    )
  end

  desc "Load items data"
  task items: :environment do
    file_path = './db/data/items.csv'
    data = CSV.read(file_path, headers: true, header_converters: :symbol)

    data.each do |line|
      Item.create!(line.to_hash)
    end

    ActiveRecord::Base.connection.execute(
      "ALTER SEQUENCE items_id_seq RESTART WITH #{Item.maximum(:id) + 1}"
    )
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

    ActiveRecord::Base.connection.execute(
      "ALTER SEQUENCE invoice_items_id_seq RESTART WITH #{InvoiceItem.maximum(:id) + 1}"
    )
  end
end
