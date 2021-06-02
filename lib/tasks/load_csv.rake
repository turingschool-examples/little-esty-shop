
desc "destroy and reload all seed data"
task :load_csv do
  Rake::Task["initialize"].invoke
  Rake::Task["clear_data"].invoke
  Rake::Task["load_customers"].invoke
  Rake::Task["load_invoices"].invoke
  Rake::Task["load_merchants"].invoke
  Rake::Task["load_items"].invoke
  Rake::Task["load_invoice_items"].invoke
  Rake::Task["load_transactions"].invoke
end

task initialize: :environment do
  require './app/models/application_record.rb'
  require './app/models/customer.rb'
  require './app/models/invoice.rb'
  require './app/models/merchant.rb'
  require './app/models/item.rb'
  require './app/models/invoice_item.rb'
  require './app/models/transaction.rb'
end

desc "destroy existing records"
task clear_data: :environment do

  Customer.destroy_all
  Merchant.destroy_all
  Item.destroy_all
  Invoice.destroy_all
  InvoiceItem.destroy_all
  Transaction.destroy_all
end

desc "load customers"
task load_customers: :environment do
  require 'csv'
  require './app/models/application_record.rb'
  require './app/models/customer.rb'
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
  CSV.foreach('./db/data/invoice_items.csv', :headers => true,  header_converters: :symbol, converters: :all, :encoding => 'UTF-8') do |row|
    t = InvoiceItem.new
    t.quantity = row[:quantity].to_i
    t.unit_price = row[:unit_price].to_i
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
  CSV.foreach('./db/data/transactions.csv', :headers => true, header_converters: :symbol, :encoding => 'UTF-8') do |row|
    t = Transaction.new
    t.invoice_id = row[:invoice_id]
    t.credit_card_number = row[:credit_card_number]
    t.credit_card_expiration_date = row[:credit_card_expiration_date]
    t.result = row[:result]
    t.save
  end
end

task load_invoices: :environment do
  require 'csv'
  require './app/models/application_record.rb'
  require './app/models/invoice.rb'
  CSV.foreach('./db/data/invoices.csv', :headers => true, header_converters: :symbol, :encoding => 'UTF-8') do |row|
    t = Invoice.new
    t.status = row[:status]
    t.customer_id = row[:customer_id]
    t.save
  end
end