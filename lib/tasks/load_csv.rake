require 'csv'
namespace :csv_load do
  desc "load tables from CSV"
  task :customers => :environment do
    CSV.foreach("db/data/customers.csv", headers: true) do |row|
      Customer.create!(first_name: row["first_name"], last_name: row["last_name"])
    end
  end

  task :merchants => :environment do
    CSV.foreach("db/data/merchants.csv", headers: true) do |row|
      Merchant.create!(name: row["name"])
    end
  end

  task :items => :environment do
    CSV.foreach("db/data/items.csv", headers: true) do |row|
      Item.create!(name: row["name"], description: row["description"], unit_price: row["unit_price"], merchant_id: row["merchant_id"])
    end
  end

  task :invoices => :environment do
    CSV.foreach("db/data/invoices.csv", headers: true) do |row|
      Invoice.create!(customer_id: row["customer_id"], status: row["status"])
    end
  end

  task :transactions => :environment do
    CSV.foreach("db/data/transactions.csv", headers: true) do |row|
      Transaction.create!(invoice_id: row["invoice_id"], credit_card_number: row["credit_card_number"], result: row["result"])
    end
  end

  task :invoice_items => :environment do
    CSV.foreach("db/data/invoice_items.csv", headers: true) do |row|
      InvoiceItem.create!(item_id: row["item_id"], invoice_id: row["invoice_id"], quantity: row["quantity"], unit_price: row["unit_price"], status: row["status"])
    end
  end

  task :all => :environment do
    Rake::Task["csv_load:customers"].invoke
    Rake::Task["csv_load:merchants"].invoke
    Rake::Task["csv_load:items"].invoke
    Rake::Task["csv_load:invoices"].invoke
    Rake::Task["csv_load:transactions"].invoke
    Rake::Task["csv_load:invoice_items"].invoke
  end
end
