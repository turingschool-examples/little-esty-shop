require 'csv'

namespace :csv_load do
  desc 'All'
  task all: [:customers, :merchants, :invoices, :items, :invoice_items, :transactions]

  desc "Create seeds from customers CSV"
  task :customers => [:environment] do
    Customer.destroy_all
    
    file = "db/data/customers.csv"
    
    CSV.foreach(file, :headers => true) do |row|
      Customer.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  desc "Create seeds from merchants CSV"
  task :merchants => [:environment] do
    Merchant.destroy_all
    
    file = "db/data/merchants.csv"
    
    CSV.foreach(file, :headers => true) do |row|
      Merchant.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end
  
  desc "Create seeds from invoices CSV"
  task :invoices => [:environment] do
    Invoice.destroy_all
    
    file = "db/data/invoices.csv"
    
    CSV.foreach(file, :headers => true) do |row|
      Invoice.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  desc "Create seeds from items CSV"
  task :items => [:environment] do
    Item.destroy_all
    
    file = "db/data/items.csv"
    
    CSV.foreach(file, :headers => true) do |row|
      Item.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  desc "Create seeds from invoice_items CSV"
  task :invoice_items => [:environment] do
    InvoiceItem.destroy_all
    
    file = "db/data/invoice_items.csv"
    
    CSV.foreach(file, :headers => true) do |row|
      InvoiceItem.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  desc "Create seeds from transactions CSV"
  task :transactions => [:environment] do
    Transaction.destroy_all
    
    file = "db/data/transactions.csv"
    
    CSV.foreach(file, :headers => true) do |row|
      row.delete(3)
      Transaction.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end
end