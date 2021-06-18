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
  task all: %W(customers merchants invoices items invoice_items merchants transactions) do
    print "All CSV files loaded. \n"
  end
end