require 'csv'

namespace :csv_load do

  task merchants: :environment do
    Merchant.destroy_all
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end

    table = 'merchants'
    next_id = 101
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{next_id}")
  end

  task customers: :environment do
    Customer.destroy_all
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end

    table = 'customers'
    next_id = 1001
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{next_id}")
  end

  task items: :environment do
    Item.destroy_all
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_h)
    end

    table = 'items'
    next_id = 2484
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{next_id}")
  end

  task invoices: :environment do
    Invoice.destroy_all
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_h)
    end

    table = 'invoices'
    next_id = 901
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{next_id}")
  end

  task invoice_items: :environment do
    InvoiceItem.destroy_all
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end

    table = 'invoice_items'
    next_id = 4015
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{next_id}")
  end

  task transactions: :environment do
    Transaction.destroy_all
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_h)
    end

    table = 'transactions'
    next_id = 1045
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{next_id}")
  end

  task :all do
    tables = [:customers, :merchants, :invoices, :items, :invoice_items, :transactions]
    tables.each do |table|
      Rake::Task["csv_load:#{table}"].invoke
    end
  end
end
