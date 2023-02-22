require 'csv'

namespace :csv_load do
  task :all => [:merchants, :customers, :items, :invoices, :invoice_items, :transactions]

  task :merchants => :environment do
    csv_text = File.read('./db/data/merchants.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Merchant.create!(row.to_hash)
    end
  end
  
  task :customers => :environment do
    csv_text = File.read('./db/data/customers.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Customer.create!(row.to_hash)
    end
  end
  
  task :items => :environment do
    csv_text = File.read('./db/data/items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Item.create!(row.to_hash)
    end
  end
  
  task :invoices => :environment do
    csv_text = File.read('./db/data/invoices.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      if row["status"] == "in progress"
        row["status"] = 0
      elsif row["status"] == "cancelled"
        row["status"] = 1
      else
        row["status"] = 2
      end
      Invoice.create!(row.to_hash)
    end
  end
  
  task :invoice_items => :environment do
    csv_text = File.read('./db/data/invoice_items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      if row["status"] == "pending"
        row["status"] = 0
      elsif row["status"] == "packaged"
        row["status"] = 1
      else
        row["status"] = 2
      end
      InvoiceItem.create!(row.to_hash)
    end
  end
  
  task :transactions => :environment do
    csv_text = File.read('./db/data/transactions.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      row["result"] == "success" ? row[:result] = 0 : row[:result] = 1
      Transaction.create!(row.to_hash)
    end
  end
end 