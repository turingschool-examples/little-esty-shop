# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'csv'

Rails.application.load_tasks

namespace :csv_load do
  desc 'Seed Customers Table!'
  task :customers => :environment do
    csv_text = File.read("db/data/customers.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      t = Customer.new
      t.id = row['id']
      t.first_name = row['first_name']
      t.last_name = row['last_name']
      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save
      puts "Customer #{t.first_name} #{t.last_name} is created"
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  desc 'Seed Items Table!'
  task :items => :environment do
    csv_text = File.read("db/data/items.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      t = Item.new
      t.id = row['id']
      t.name = row['name']
      t.description = row['description']
      t.unit_price = row['unit_price']
      t.merchant_id = row['merchant_id']
      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save
      puts "#{t.name} is created"
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end
  
  desc 'Seed Invoices Table!'
  task :invoices => :environment do
    csv_text = File.read("db/data/invoices.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      t = Invoice.new
      t.id = row['id']
      t.customer_id = row['customer_id']

      if row['status'] == "cancelled"
        t.status = 0
      elsif row['status'] == "in progress"
        t.status = 1
      elsif row['status'] == "completed"
        t.status = 2
      end

      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save
      puts "Invoice #{t.id} is created"
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  desc 'Seed Invoice_Items Table!'
  task :invoice_items => :environment do
    csv_text = File.read("db/data/invoice_items.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      t = InvoiceItem.new
      t.id = row['id']
      t.item_id = row['item_id']
      t.invoice_id = row['invoice_id']
      t.quantity = row['quantity']
      t.unit_price = row['unit_price']

      if row['status'] == "packaged"
        t.status = 0
      elsif row['status'] == "pending"
        t.status = 1
      elsif row['status'] == "shipped"
        t.status = 2
      end

      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save
      puts "Invoice_Item #{t.item_id} is created"
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  desc 'Seed Merchant Table!'
  task :merchants => :environment do
    csv_text = File.read("db/data/merchants.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      t = Merchant.new
      t.id = row['id']
      t.name = row['name']
      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save
      puts "#{t.name} is created"
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  desc 'Seed Transaction Table!'
  task :transactions => :environment do
    csv_text = File.read("db/data/transactions.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      t = Transaction.new
      t.id = row['id']
      t.invoice_id = row['invoice_id']
      t.credit_card_number = row['credit_card_number']
      t.credit_card_expitation_date = row['credit_card_expiration_date']

      if row['result'] == "failed"
        t.result = 0
      elsif row['result'] == "success"
        t.result = 1
      end

      t.created_at = row['created_at']
      t.updated_at = row['updated_at']

      t.save
      puts "#{t.id} is created"
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end
end