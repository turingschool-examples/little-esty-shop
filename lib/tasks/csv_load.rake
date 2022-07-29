require 'csv'

namespace :load_csv do
  task :merchants => :environment do
    csv_text = File.read('./db/data/merchants.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Merchant.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  task :items => :environment do
    csv_text = File.read('./db/data/items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Item.create!(row.to_hash)
    end
  ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end
  
  task :customers => :environment do
    csv_text = File.read('./db/data/customers.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Customer.create!(row.to_hash)
    end
  ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end
  
  task :invoices => :environment do
    csv_text = File.read('./db/data/invoices.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Invoice.create!(row.to_hash)
    end
  ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end
  
  task :invoice_items => :environment do
    csv_text = File.read('./db/data/invoice_items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      InvoiceItem.create!(row.to_hash)
    end
  ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  task :transactions => :environment do
    csv_text = File.read('./db/data/transactions.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Transaction.create!(row.to_hash)
    end
  ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  task delete_all: :environment do
    InvoiceItem.destroy_all
    Item.destroy_all
    Merchant.destroy_all
    Transaction.destroy_all
    Invoice.destroy_all
    Customer.destroy_all
    puts "'Delete All' Complete"
  end

  task all: [:merchants, :items, :customers, :invoices, :invoice_items, :transactions]

  desc 'reset all table primary keys'
  task reset_keys: :environment do
    ActiveRecord::Base.connection.tables.each do |table_name|
      ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
      puts "'Reset Keys' Complete"
    end
  end
end
