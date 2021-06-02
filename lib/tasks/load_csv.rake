desc "destroy existing records" 
task :clear_data do
  Customer.destroy_all
  Merchant.destroy_all
  Item.destroy_all
  Invoice.destroy_all
  ItemInvoice.destroy_all
  Transaction.destroy_all
end

desc "load customers"
task load_customers: :environment do
  require 'csv'
  require './app/models/application_record.rb'
  require './app/models/customer.rb'
  Customer.connection
  # CSV.foreach('./db/data/customers.csv', headers: true, header_converters: :symbol) do |row|
  #   Customer.new(row)
  # end
  # csv_text = File.read(Rails.root.join('db', 'data', 'customers.csv'))
  # csv = CSV.foreach(csv_text, :headers => true,  header_converters: :symbol, :encoding => 'UTF-8')
  # csv.foreach do |row|
  CSV.foreach('./db/data/customers.csv', :headers => true,  header_converters: :symbol, :encoding => 'UTF-8') do |row|
    t = Customer.new
    t.first_name = row[:first_name]
    t.last_name = row[:last_name]
    t.save
  end
end

task load_invoice_items: :environment do
  require 'csv'
  require './app/models/application_record.rb'
  require './app/models/invoice_item.rb'
  InvoiceItem.connection
  CSV.foreach('./db/data/invoice_items.csv', :headers => true,  header_converters: :symbol, converters: :all, :encoding => 'UTF-8') do |row|
    t = InvoiceItem.new
    t.quantity = row[:quantity]
    t.unit_price = row[:unit_price]
    t.status = row[:status]
    t.item_id = row[:item_id]
    t.invoice_id = row[:invoice_id]
    t.save
  end
end

task load_items: :environment do
  require 'csv'
  require './app/models/application_record.rb'
  require './app/models/item.rb'
  Item.connection
  CSV.foreach('./db/data/items.csv', :headers => true, header_converters: :symbol, :encoding => 'UTF-8') do |row|
    t = Item.new
    t.name = row[:name]
    t.description = row[:description]
    t.unit_price = row[:unit_price].to_i
    t.enabled = row[:enabled]
    t.merchant_id = row[:merchant_id]
    t.save
  end
end

task load_merchants: :environment do
  require 'csv'
  require './app/models/application_record.rb'
  require './app/models/merchant.rb'
  Merchant.connection
  CSV.foreach('./db/data/merchants.csv', :headers => true, header_converters: :symbol, :encoding => 'UTF-8') do |row|
    t = Merchant.new
    t.name = row[:name]
    t.save
  end
end

task load_transactions: :environment do
  require 'csv'
  require './app/models/application_record.rb'
  require './app/models/transaction.rb'
  Transaction.connection
  CSV.foreach('./db/data/transactions.csv', :headers => true, header_converters: :symbol, :encoding => 'UTF-8') do |row|
    t = Transaction.new
    t.name = row[:name]
    t.save
  end
end

task
  
end