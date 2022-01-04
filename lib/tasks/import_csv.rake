namespace :import_csv do
  require 'csv'
  desc "Import customer data from csv"
  task customer_data: :environment do
    customer_data
  end

  desc "Import invoice_items data from csv"
  task invoice_item_data: :environment do
    invoice_item_data
  end

  desc "Import invoices data from csv"
  task invoice_data: :environment do
    invoice_data
  end

  desc "Import items data from csv"
  task item_data: :environment do
    item_data
  end

  desc "Import merchants data from csv"
  task merchant_data: :environment do
    merchant_data
  end

  desc "Import transactions data from csv"
  task transaction_data: :environment do
    transaction_data
  end

  desc "Import all csv data"
  task all: :environment do
    merchant_data
    item_data
    customer_data
    invoice_data
    transaction_data
    invoice_item_data
  end
end

def transaction_data
  CSV.foreach('db/data/transactions.csv', headers: true) do |row|
    Transaction.create!(row.to_hash)
  end
  ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
end

def merchant_data
  CSV.foreach('db/data/merchants.csv', headers: true) do |row|
    Merchant.create!(row.to_hash)
  end
  ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
end

def item_data
  CSV.foreach('db/data/items.csv', headers: true) do |row|
    Item.create!(row.to_hash)
  end
  ActiveRecord::Base.connection.reset_pk_sequence!('items')
end

def invoice_data
  CSV.foreach('db/data/invoices.csv', headers: true) do |row|
    Invoice.create!(row.to_hash)
  end
  ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
end

def invoice_item_data
  CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
    InvoiceItem.create!(row.to_hash)
  end
  ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
end

def customer_data
  CSV.foreach('db/data/customers.csv', headers: true) do |row|
    Customer.create!(row.to_hash)
  end
  ActiveRecord::Base.connection.reset_pk_sequence!('customers')
end
