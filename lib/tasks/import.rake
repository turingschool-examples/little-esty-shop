require 'csv'
# require 'pry'
#these need to be created in such a n order with dependencies?

namespace :csv_load do
  desc "Import teams from csv file"
  task :merchants => [:environment] do
    Merchant.destroy_all
    file_5 = "db/data/merchants.csv"
    CSV.foreach(file_5, :headers => true, header_converters: :symbol) do |row|
      Merchant.create(row.to_hash)
    end
  end
  task :items => [:environment] do
    Item.destroy_all
    file_4 = "db/data/items.csv"
    CSV.foreach(file_4, :headers => true, header_converters: :symbol) do |row|
      Item.create(row.to_hash)
    end
  end
  task :customers => [:environment] do
    Customer.destroy_all
    file = "db/data/customers.csv"
    CSV.foreach(file, :headers => true, header_converters: :symbol) do |row|
      Customer.create(row.to_hash)
    end
  end
  task :invoices => [:environment] do
    Invoice.destroy_all
    file_2 = "db/data/invoices.csv"
    CSV.foreach(file_2, :headers => true, header_converters: :symbol) do |row|
      if row[2] == "in progress"
        row[2] = 0
      elsif row[2] == "completed"
        row[2] = 1
      else
        row[2] = 2
      end
      Invoice.create(row.to_hash)
    end
  end
  task :transactions => [:environment] do
    Transaction.destroy_all
    file_6 = "db/data/transactions.csv"
    CSV.foreach(file_6, :headers => true, header_converters: :symbol) do |row|
      Transaction.create(row.to_hash)
    end
  end
  task :invoice_items => [:environment] do
    InvoiceItem.destroy_all
    file_3 = "db/data/invoice_items.csv"
    CSV.foreach(file_3, :headers => true, header_converters: :symbol) do |row|
      if row[5] == "packaged"
        row[5] = 0
      elsif row[5] == "pending"
        row[5] = 1
      else
        row[5] = 2
      end
      InvoiceItem.create(row.to_hash)
    end
  end
  task :all => [:merchants, :items, :customers, :invoices, :transactions, :invoice_items] do
  end
end
