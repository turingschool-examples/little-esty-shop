require 'csv'

namespace :csv_load do
  task :customers => :environment do
    Customer.destroy_all
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end
  end

  task :merchants => :environment do
    Merchant.destroy_all
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end
  end

  task :items => :environment do
    Item.destroy_all
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_h)
    end
  end

  task :invoices => :environment do
    Invoice.destroy_all
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_h)
    end
  end

  task :invoice_items => :environment do
    InvoiceItem.destroy_all
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end
  end

  task :transactions => :environment do
    Transaction.destroy_all
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_h)
    end
  end

  task :all do
    Rake::Task['csv_load:customers'].invoke
    Rake::Task['csv_load:merchants'].invoke
    Rake::Task['csv_load:items'].invoke
    Rake::Task['csv_load:invoices'].invoke
    Rake::Task['csv_load:invoice_items'].invoke
    Rake::Task['csv_load:transactions'].invoke
  end
end
