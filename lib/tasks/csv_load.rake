require 'csv'

namespace :csv_load do
  task customers: :environment do
    Customer.destroy_all
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end
    table = 'customers'
    auto_inc_val = 1001
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_inc_val}")
  end

  task merchants: :environment do
    Merchant.destroy_all
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end
    table = 'merchants'
    auto_inc_val = 101
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_inc_val}")
  end

  task invoice_items: :environment do
    InvoiceItem.destroy_all
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end
    table = 'invoice_items'
    auto_inc_val = 4015
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_inc_val}")
  end

  task invoices: :environment do
    Invoice.destroy_all
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_h)
    end
    table = 'invoices'
    auto_inc_val = 901
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_inc_val}")
  end

  task items: :environment do
    Item.destroy_all
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_h)
    end
    table = 'items'
    auto_inc_val = 2484
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_inc_val}")
  end

  task transactions: :environment do
    Transaction.destroy_all
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_h)
    end
    table = 'transactions'
    auto_inc_val = 1045
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_inc_val}")
  end
 
  task :all do
    tables = [:customers, :merchants, :invoices, :items, :invoice_items, :transactions]
    tables.each do |table|
      Rake::Task["csv_load:#{table}"].invoke
    end
  end
end