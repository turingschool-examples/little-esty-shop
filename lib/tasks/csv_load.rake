require 'csv'

namespace :csv_load do

  task :create_customers => :environment do
    CSV.foreach(Rails.root.join('db/data/customers.csv'), headers: true) do |row|
      Customer.create!( {
        id: row["id"],
        first_name: row["first_name"],
        last_name: row["last_name"]
        } )
    end
    table = 'customers'
    auto_inc_val = 1001
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_inc_val}")
  end

  task :create_invoice_items => :environment do
    CSV.foreach(Rails.root.join('db/data/invoice_items.csv'), headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
    table = 'invoice_items'
    auto_inc_val = 4015
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_inc_val}")
  end

  task :create_invoices => :environment do
    CSV.foreach(Rails.root.join('db/data/invoices.csv'), headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
    table = 'invoices'
    auto_inc_val = 901
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_inc_val}")
  end

  task :create_items => :environment do
    CSV.foreach(Rails.root.join('db/data/items.csv'), headers: true) do |row|
      Item.create!(row.to_hash)
    end
    table = 'items'
    auto_inc_val = 2484
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_inc_val}")
  end

  task :create_merchants => :environment do
    CSV.foreach(Rails.root.join('db/data/merchants.csv'), headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
    table = 'merchants'
    auto_inc_val = 101
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_inc_val}")
  end

  task :create_transactions => :environment do
    CSV.foreach(Rails.root.join('db/data/transactions.csv'), headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
    table = 'transactions'
    auto_inc_val = 1045
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_inc_val}")
  end
end
