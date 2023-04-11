require 'csv'
namespace :csv_load do
  desc "load tables from CSV"
  task :customers => :environment do
    CSV.foreach("db/data/customers.csv", headers: true) do |row|
      Customer.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customer')
  end

  task :merchants => :environment do
    CSV.foreach("db/data/merchants.csv", headers: true) do |row|
      Merchant.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchant')
  end

  task :items => :environment do
    CSV.foreach("db/data/items.csv", headers: true) do |row|
      Item.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('item')
  end

  task :invoices => :environment do
    CSV.foreach("db/data/invoices.csv", headers: true) do |row|
      Invoice.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice')
  end

  task :transactions => :environment do
    CSV.foreach("db/data/transactions.csv", headers: true) do |row|
      Transaction.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transaction')
  end

  task :invoice_items => :environment do
    CSV.foreach("db/data/invoice_items.csv", headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_item')
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
