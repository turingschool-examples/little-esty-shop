require 'csv'
require 'pry'
#these need to be created in such a n order with dependencies?



desc "Import teams from csv file"
task :csv_load => [:environment] do
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
      InvoiceItem.create(row.to_hash)
    end
  end

  task :all => [:merchants, :items, :customers, :invoices, :transactions, :invoice_items] do
  end
end
