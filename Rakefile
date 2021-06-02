# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'csv'
Rails.application.load_tasks

namespace :csv_load do
  desc "load customer csv"
  task customers: :environment do
    csv_path = 'db/data/customers.csv'
    csv = CSV.open(csv_path, headers: true)
    csv.each do |row|
      Customer.create!(
        first_name: row['first_name'],
        last_name: row['first_name']
      )
    end
  end
  desc "load invoice_items csv"
  task invoice_items: :environment do
    puts 'invoice_items'
  end
  desc "load invoices csv"
  task invoices: :environment do
    puts 'invoices'
  end
  desc "load items csv"
  task items: :environment do
    puts 'items'
  end
  desc "load merchants csv"
  task merchants: :environment do
    puts 'merchants'
  end
  desc "load transactions csv"
  task transactions: :environment do
    puts 'transactions'
  end
  desc 'run all csv files'
  task all: %W(customers invoice_items invoices items merchants transactions) do
    puts 'all'
  end
end