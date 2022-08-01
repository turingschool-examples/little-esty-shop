require 'csv'
namespace :csv_load do
  desc "imports merchants from a csv file"
  task merchants: :environment do
    Merchant.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    file = 'db/data/merchants.csv'
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Merchant.create(row.to_hash)
      ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
      # p row
    end
    table = 'merchants'
    # ai_val = 101
    # ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{ai_val}")
  end

  desc "imports items from a csv file"
  task items: :environment do
    Item.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    file = 'db/data/items.csv'
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Item.create(row.to_hash)
      ActiveRecord::Base.connection.reset_pk_sequence!('items')
      # p row
    end
    table = 'items'
    # ai_val = 2484
    # ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{ai_val}")
  end

  desc "imports customers from a csv file"
  task customers: :environment do
    Customer.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    file = 'db/data/customers.csv'
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Customer.create(row.to_hash)
      ActiveRecord::Base.connection.reset_pk_sequence!('customers')
      # p row
    end
      table = 'customers'
      # ai_val = 1001
      # ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{ai_val}")
  end

  desc "imports invoices from a csv file"
  task invoices: :environment do
    Invoice.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    file = 'db/data/invoices.csv'
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Invoice.create(row.to_hash)
      ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
      # p row
    end
      table = 'invoices'
      # ai_val = 901
      # ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{ai_val}")
  end

  desc "imports invoice_items from a csv file"
  task invoice_items: :environment do
    InvoiceItem.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')

    file = 'db/data/invoice_items.csv'
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create(row.to_hash)
      ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
      # p row
    end
    table = 'invoice_items'
    # ai_val = 4015
    # ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{ai_val}")
  end

  desc "imports transactions from a csv file"
  task transactions: :environment do
    Transaction.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')

    file = 'db/data/transactions.csv'
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      Transaction.create!(row.to_hash)
      ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
      # p row
    end
      table = 'transactions'
      # ai_val = 1045
      # ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{ai_val}")
  end

  desc 'import all csv files'
  task all: :environment do
    tasks = [ 'csv_load:merchants',
              'csv_load:items',
              'csv_load:customers',
              'csv_load:invoices',
              'csv_load:invoice_items',
              'csv_load:transactions'
              ]
    tasks.each do |task|
      Rake::Task[task].invoke
    end

    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end
end
