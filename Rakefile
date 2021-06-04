# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'csv'
Rails.application.load_tasks

namespace :csv_load do
  desc "load customer csv"
  task customers: :environment do
    csv_path = 'db/data/customers.csv'
    i = 1
    CSV.foreach(csv_path, headers: true) do |row|
      if Customer.create! row.to_h
        print "#{i} Customer Records Done\r"
        i = i + 1
      end
    end
    print "\n"
  end

  desc "load invoices csv"
  task invoices: :environment do
    csv_path = 'db/data/invoices.csv'
    i = 1
    CSV.foreach(csv_path, headers: true) do |row|
      if Invoice.create! row.to_h
        print "#{i} Invoice Records Done\r"
        i = i + 1
      end
    end
    print "\n"
  end

  desc "load items csv"
  task items: :environment do
    csv_path = 'db/data/items.csv'
    i = 1
    CSV.foreach(csv_path, headers: true) do |row|
      if Item.create! row.to_h
        print "#{i} Item Records Done\r"
        i = i + 1
      end
    end
  print "\n"
  end

  desc "load invoice_items csv"
  task invoice_items: :environment do
    csv_path = 'db/data/invoice_items.csv'
    i = 1
    CSV.foreach(csv_path, headers: true) do |row|
      if InvoiceItem.create! row.to_h
        print "#{i} InvoiceItem Records Done\r"
        i = i + 1
      end
    end
    print "\n"
  end

  desc "load merchants csv"
  task merchants: :environment do
    csv_path = 'db/data/merchants.csv'
    i = 1
    CSV.foreach(csv_path, headers: true) do |row|
      if Merchant.create! row.to_h
        print "#{i} Merchant Records Done\r"
        i = i + 1
      end
    end
    print "\n"
  end

  desc "load transactions csv"
  task transactions: :environment do
    csv_path = 'db/data/transactions.csv'
    i = 1
    CSV.foreach(csv_path, headers: true) do |row|
      if Transaction.create! row.to_h
        print "#{i} Transaction Records Done\r"
        i = i + 1
      end
    end
    print "\n"
  end

  desc 'run all csv files'
  task all: %W(customers merchants invoices items invoice_items transactions) do
    Rails.env = 'development'
    print "All CSV files loaded. \n"
  end
end

# TODO refactor below code to use a method

desc "load test data csv's"
task load_test_data: :environment do
  Rails.env = 'test'
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
  files = {
    'customers' => 'db/data/test_data/customers.csv',
    'merchants' => 'db/data/test_data/merchants.csv',
    'invoices' => 'db/data/test_data/invoices.csv',
    'items' => 'db/data/test_data/items.csv',
    'invoice_items' => 'db/data/test_data/invoice_items.csv',
    'transactions' => 'db/data/test_data/transactions.csv',
  }
  files.each do |table, filename|
    csv = CSV.read(filename, headers: true)
    headers = csv.headers
    values_list = csv.map do |rows|
      rows.values_at.map do |values|
        ActiveRecord::Base.connection.quote(values)
      end
    end

    ActiveRecord::Base.connection.execute <<-SQL
      INSERT INTO #{table} (#{headers.join(",")}) VALUES
      #{values_list.map { |values| "(#{values.join(",")})" }.join(", ")}
    SQL
  end

end

desc 'load test data to database'
task load_test_data_seed: :environment do
  Rails.env = 'test'
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
  customers = []
  items = []
  50.times do
    customers << Customer.create!(FactoryBot.attributes_for(:customer))
  end

  50.times do
    m = Merchant.create!(FactoryBot.attributes_for(:merchant))
    items << m.items.create!(FactoryBot.attributes_for(:item))
    items << m.items.create!(FactoryBot.attributes_for(:item))
  end

  customers.each do |customer|
    rand(1..3).times do
      item = items.sample
      attrs = FactoryBot.attributes_for(:invoice)
      attrs[:customer] = customer
      invoice = item.invoices.create!(attrs)
      InvoiceItem.find_by(invoice_id: invoice.id, item_id: item.id)
                 .update(unit_price: item.unit_price, quantity: rand(0..5), status: rand(0..2))
    end
  end

  invoices = Invoice.all
  invoices.each do |invoice|
    invoice.transactions.create!(FactoryBot.attributes_for(:transaction))
  end
end
#
# psql -U zach -d little-etsy-shop_test -c "Copy (select * from customers) To STDOUT With CSV HEADER DELIMITER ',';" > ./db/data/test_data/customers.csv
# psql -U zach -d little-etsy-shop_test -c "Copy (select * from merchants) To STDOUT With CSV HEADER DELIMITER ',';" > ./db/data/test_data/merchants.csv
# psql -U zach -d little-etsy-shop_test -c "Copy (select * from invoices) To STDOUT With CSV HEADER DELIMITER ',';" > ./db/data/test_data/invoices.csv
# psql -U zach -d little-etsy-shop_test -c "Copy (select * from items) To STDOUT With CSV HEADER DELIMITER ',';" > ./db/data/test_data/items.csv
# psql -U zach -d little-etsy-shop_test -c "Copy (select * from invoice_items) To STDOUT With CSV HEADER DELIMITER ',';" > ./db/data/test_data/invoice_items.csv
# psql -U zach -d little-etsy-shop_test -c "Copy (select * from transactions) To STDOUT With CSV HEADER DELIMITER ',';" > ./db/data/test_data/transactions.csv
#
# psql -U zach -d little-etsy-shop_test -c "Copy (select * from customers) To STDOUT With CSV DELIMITER ',';" > ./db/data/test_data/customers.csv
# psql -U zach -d little-etsy-shop_test -c "Copy (select * from merchants) To STDOUT With CSV DELIMITER ',';" > ./db/data/test_data/merchants.csv
# psql -U zach -d little-etsy-shop_test -c "Copy (select * from invoices) To STDOUT With CSV DELIMITER ',';" > ./db/data/test_data/invoices.csv
# psql -U zach -d little-etsy-shop_test -c "Copy (select * from items) To STDOUT With CSV DELIMITER ',';" > ./db/data/test_data/items.csv
# psql -U zach -d little-etsy-shop_test -c "Copy (select * from invoice_items) To STDOUT With CSV DELIMITER ',';" > ./db/data/test_data/invoice_items.csv
# psql -U zach -d little-etsy-shop_test -c "Copy (select * from transactions) To STDOUT With CSV DELIMITER ',';" > ./db/data/test_data/transactions.csv
