require "csv"

namespace :csv_seed do
  task import_customers: :environment do
    CSV.foreach("db/data/customers.csv", headers: true) do |row|
      Customer.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("customers")
  end

  task import_merchants: :environment do
    CSV.foreach("db/data/merchants.csv", headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("merchants")
  end

  task import_invoices: :environment do
    CSV.foreach("db/data/invoices.csv", headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("invoices")
  end

  task import_items: :environment do
    CSV.foreach("db/data/items.csv", headers: true) do |row|
      row = row.to_hash
      row[:unit_price] = row[:unit_price].to_f / 100
      Item.create!(row)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("items")
  end

  task import_transactions: :environment do
    CSV.foreach("db/data/transactions.csv", headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("transactions")
  end

  task import_invoice_items: :environment do
    CSV.foreach("db/data/invoice_items.csv", headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("invoice_items")
  end

  task import_all: :environment do
    Rake::Task["csv_seed:import_customers"].execute
    Rake::Task["csv_seed:import_merchants"].execute
    Rake::Task["csv_seed:import_items"].execute
    Rake::Task["csv_seed:import_invoices"].execute
    Rake::Task["csv_seed:import_transactions"].execute
    Rake::Task["csv_seed:import_invoice_items"].execute
    puts "Created #{Customer.count} Customers"
    puts "Created #{Merchant.count} Merchants"
    puts "Created #{Item.count} Items"
    puts "Created #{Invoice.count} Invoices"
    puts "Created #{Transaction.count} Transactions"
    puts "Created #{InvoiceItem.count} Invoice Items"
  end
end
