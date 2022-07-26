require 'csv'

namespace :csv_load do
    desc "Imports Customer CSV file into an ActiveRecord table"

    task :merchants => :environment do
      file = './db/data/merchants.csv'
      CSV.foreach(file, :headers => true) do |row|
        Merchant.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!(:merchants)
    end

    task :items => :environment do
      file = './db/data/items.csv'
      CSV.foreach(file, :headers => true) do |row|
        Item.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!(:items)
    end

    task :customers => :environment do
      file = './db/data/customers.csv'
      CSV.foreach(file, :headers => true) do |row|
        Customer.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!(:customers)
    end

    task :invoices => :environment do
      file = './db/data/invoices.csv'
      CSV.foreach(file, :headers => true) do |row|
        Invoice.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!(:invoices)
    end

    task :invoice_items => :environment do
      file = './db/data/invoice_items.csv'
      CSV.foreach(file, :headers => true) do |row|
        InvoiceItem.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!(:invoice_items)
    end

    task :transactions => :environment do
      file = './db/data/transactions.csv'
      CSV.foreach(file, :headers => true) do |row|
        Transaction.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!(:transactions)
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
      end
  end

end

# require 'csv'

# namespace :csv_load do
#     desc "Create seed files for all CSV"
#     task :all => :environment do
#       Rake::Task["csv_load:customers"].invoke
#       Rake::Task["csv_load:merchants"].invoke
#       Rake::Task["csv_load:invoices"].invoke
#       Rake::Task["csv_load:items"].invoke
#       Rake::Task["csv_load:invoice_items"].invoke
#       Rake::Task["csv_load:transactions"].invoke
#     end
#   end
  
