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
      t = Invoice_Item.new
      t.id = row['id']
      t.customer_id = row['customer_id']
      t.status = row['status']
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
      t = Invoice_Item.new
      t.id = row['id']
      t.item_id = row['item_id']
      t.invoice_id = row['invoice_id']
      t.quantity = row['quantity']
      t.unit_price = row['unit_price']
      t.status = row['status']
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
end