require 'csv'

namespace :csv_load do
  task :merchants => :environment do
    Merchant.destroy_all
    CSV.foreach("db/data/merchants.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  task :customers => :environment do
    Customer.destroy_all
    CSV.foreach("db/data/customers.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
      Customer.create!(row.to_hash)
    end
  end

  task :items => :environment do
    Item.destroy_all
    CSV.foreach("db/data/items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
      Item.create!(row.to_hash)
    end
  end

   task :invoices => :environment do
    Invoice.destroy_all
    CSV.foreach("db/data/invoices.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
      Invoice.parse_csv(row.to_hash)
    end
  end

  task :invoice_items => :environment do
    InvoiceItem.destroy_all
    CSV.foreach("db/data/invoice_items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  task :transactions => :environment do
    Transaction.destroy_all
    CSV.foreach("db/data/transactions.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
      Transaction.create!(row.to_hash)
    end
  end

  task :all => :environment do
    Rake::Task["csv_load:merchants"].invoke
    Rake::Task["csv_load:customers"].invoke
    Rake::Task["csv_load:invoices"].invoke
    Rake::Task["csv_load:transactions"].invoke
    Rake::Task["csv_load:items"].invoke
    Rake::Task["csv_load:invoice_items"].invoke
  end

end
