
require 'csv'
desc "Imports a customer file into an ActiveRecord table"
task :customer, [:filename] => :environment do
  CSV.foreach('./db/data/customers.csv', :headers => true) do |row|
    Customer.create!(row.to_hash)
  end
end

desc "Imports an invoiceItem file into an ActiveRecord table"
task :invoiceitem, [:filename] => :environment do
CSV.foreach('./db/data/invoice_items.csv', :headers => true) do |row|
  InvoiceItem.create!(row.to_hash)
  end
end

desc "Imports an invoice file into an ActiveRecord table"
task :invoice, [:filename] => :environment do
CSV.foreach('./db/data/invoices.csv', :headers => true) do |row|
  Invoice.create!(row.to_hash)
  end
end

desc "Imports an merchants file into an ActiveRecord table"
task :merchant, [:filename] => :environment do
CSV.foreach('./db/data/merchants.csv', :headers => true) do |row|
  Merchant.create!(row.to_hash)
  end
end

desc "Imports an item file into an ActiveRecord table"
task :item, [:filename] => :environment do
CSV.foreach('./db/data/items.csv', :headers => true) do |row|
  Item.create!(row.to_hash)
  end
end
desc "Imports a transaction file into an ActiveRecord table"
task :transaction, [:filename] => :environment do
CSV.foreach('./db/data/transactions.csv', :headers => true) do |row|
  Transaction.create!(row.to_hash)
  end
end


desc "Import all in order"
task :all => [ :customer, :invoice, :transaction, :merchant, :item, :invoiceitem  ] # ordered appropriately. 
