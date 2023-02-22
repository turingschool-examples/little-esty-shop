require 'csv'

namespace :csv_load do
  task :all => [:merchants, :customers, :items, :invoices, :invoice_items, :transactions, :reset]
  
  task :reset => :environment do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end

  task :merchants => :environment do
    CSV.foreach('./db/data/merchants.csv', headers: true, header_converters: :symbol ) do |info|
      Merchant.create!(info.to_hash)
    end
  end
  
  task :customers => :environment do
    CSV.foreach('./db/data/customers.csv', headers: true, header_converters: :symbol ) do |info|
      Customer.create!(info.to_hash)
    end
  end
  
  task :items => :environment do
    CSV.foreach('./db/data/items.csv', headers: true, header_converters: :symbol ) do |info|
      Item.create!(info.to_hash)
    end
  end
  
  task :invoices => :environment do
    CSV.foreach('./db/data/invoices.csv', headers: true) do |info|
      if info["status"] == "in progress"
        info["status"] = 0
      elsif info["status"] == "cancelled"
        info["status"] = 1
      else
        info["status"] = 2
      end
      Invoice.create!(info.to_hash)
    end
  end
  
  task :invoice_items => :environment do
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |info|
      if info["status"] == "pending"
        info["status"] = 0
      elsif info["status"] == "packaged"
        info["status"] = 1
      else
        info["status"] = 2
      end
      InvoiceItem.create!(info.to_hash)
    end
  end
  
  task :transactions => :environment do
    CSV.foreach('./db/data/transactions.csv', headers: true) do |info|
      info["result"] == "success" ? info[:result] = 0 : info[:result] = 1
      Transaction.create!(info.to_hash)
    end
  end
end 