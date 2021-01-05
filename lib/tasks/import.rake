require 'csv'

task :import, [:customers] => :environment do
  CSV.foreach('db/data/customers.csv', headers: true) do |row|
    Customer.create!(row.to_hash)
  end
end

task :import, [:merchants] => :environment do
  CSV.foreach('db/data/merchants.csv', headers: true) do |row|
    Merchant.create!(row.to_hash)
  end
end

task :import, [:items] => :environment do
  CSV.foreach('db/data/items.csv', headers: true) do |row|
    Item.create!(row.to_hash)
  end
end

task :import, [:invoices] => :environment do
  CSV.foreach('db/data/invoices.csv', headers: true) do |row|
    Invoice.create!(row.to_hash)
  end
end

task :import, [:transactions] => :environment do
  CSV.foreach('db/data/transactions.csv', headers: true) do |row|
    Transaction.create!(row.to_hash)
  end
end

task :import, [:invoice_items] => :environment do
  CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
    InvoiceItem.create!(row.to_hash)
  end
end

