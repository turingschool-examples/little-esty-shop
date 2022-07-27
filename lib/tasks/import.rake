require 'csv'

namespace :csv_load do

  desc "Import data from csv file to database"
  task merchants: :environment do

    file = "db/data/merchants.csv"
    CSV.foreach(file, :headers => true) do |row|
      Merchant.create(row.to_h)
    end
    puts "Merchants Created"
  end

  task items: :environment do

    file = "db/data/items.csv"
    CSV.foreach(file, :headers => true) do |row|
      Item.create(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    puts 'Items Created'
  end

  task customers: :environment do

    file = "db/data/customers.csv"

    Customer.destroy_all
    CSV.foreach(file, :headers => true) do |row|
      Customer.create(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    puts "Customers Created"
  end

  task invoices: :environment do

    file = "db/data/invoices.csv"
    CSV.foreach(file, :headers => true) do |row|
      Invoice.create(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    puts 'Invoices Created'
  end

  task invoice_items: :environment do

    file = "db/data/invoice_items.csv"
    CSV.foreach(file, :headers => true) do |row|
      InvoiceItem.create(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    puts 'Invoice Items Created'
  end

  task transactions: :environment do

    file = "db/data/transactions.csv"
    CSV.foreach(file, :headers => true) do |row|
      row[4] = if row[4] == 'success'
        0
      elsif row[4] == 'failed'
        1
      else
        raise 'unknown result'
      end
      Transaction.create(row.to_h)

    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    puts 'Transactions Created'
  end

  task delete_all: :environment do
    InvoiceItem.destroy_all
    Item.destroy_all
    Merchant.destroy_all
    Transaction.destroy_all
    Invoice.destroy_all
    Customer.destroy_all
    puts "Delete All Completed"
  end

  task :all => [:merchants, :items, :customers, :invoices, :invoice_items, :transactions]

  desc 'reset all tables primary keys'
  task reset_keys: :environment do
    ActiveRecord::Base.connection.tables.each do |table_name|
      ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
    end
  end
end
