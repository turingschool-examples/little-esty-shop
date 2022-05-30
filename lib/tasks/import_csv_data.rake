require 'csv'

namespace :csv_load do
  desc 'Transferring data from CSV to Database'
  task customers: :environment do
    Customer.destroy_all
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create(row.to_h)
    end
    # resets primary key sequence in rails based on current data
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    puts "'Customers' Created"
  end

  task invoices: :environment do
    Invoice.destroy_all
    CSV.foreach('db/data/invoices.csv', headers: true) do |row|
      row[2] = if row[2] == 'in progress'
                 0
               elsif row[2] == 'completed'
                 1
               elsif row[2] == 'cancelled'
                 2
               else
                 raise "Unknown 'status' found while creating 'Invoices'"
               end
      Invoice.create(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    puts "'Invoices' Created"
  end

  task transactions: :environment do
    Transaction.destroy_all
    CSV.foreach('db/data/transactions.csv', headers: true) do |row|
      row[4] = if row[4] == 'success'
                0
              elsif row[4] == 'failed'
                1
              else
                raise "Unknown 'result' found while creating 'Transactions'"
              end
      Transaction.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    puts "'Transactions' Created"
  end

  task merchants: :environment do
    Merchant.destroy_all
    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    puts "'Merchants' Created"
  end

  task items: :environment do
    Item.destroy_all
    CSV.foreach('db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    puts "'Items' Created"
  end

  task invoice_items: :environment do
    InvoiceItem.destroy_all
    CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
      row[5] = if row[5] == 'pending'
                 0
               elsif row[5] == 'packaged'
                 1
               elsif row[5] == 'shipped'
                 2
               else
                 raise "Unknown 'status' found while creating 'Invoice Items'"
               end
      InvoiceItem.create(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    puts "'Invoice Items' Created"
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

  task :all => [:delete_all, :customers, :invoices, :transactions, :merchants, :items, :invoice_items]

  desc 'reset all table primary keys'
  task reset_keys: :environment do
    ActiveRecord::Base.connection.tables.each do |table_name|
      ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
    end
  end
end
