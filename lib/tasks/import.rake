require 'csv'
# require 'pry'
#these need to be created in such a n order with dependencies?



desc "Import teams from csv file"
task :import => [:environment] do
  InvoiceItem.destroy_all
  Transaction.destroy_all
  Invoice.destroy_all
  Item.destroy_all
  Customer.destroy_all
  Merchant.destroy_all

  file_5 = "db/data/merchants.csv"
  CSV.foreach(file_5, :headers => true, header_converters: :symbol) do |row|
    Merchant.create(row.to_hash)
  end

  file_4 = "db/data/items.csv"
  CSV.foreach(file_4, :headers => true) do |row|
    Item.create(row.to_hash)
  end


  file = "db/data/customers.csv"
  CSV.foreach(file, :headers => true) do |row|
    Customer.create(row.to_hash)
  end

  file_2 = "db/data/invoices.csv"
  CSV.foreach(file_2, :headers => true) do |row|
    Invoice.create(row.to_hash)
  end

  file_6 = "db/data/transactions.csv"
  CSV.foreach(file_6, :headers => true) do |row|
    Transaction.create(row.to_hash)
  end

  file_3 = "db/data/invoice_items.csv"
  CSV.foreach(file_3, :headers => true) do |row|
    InvoiceItem.create(row.to_hash)
  end
end

#task :import_all => [:merchants, :]
