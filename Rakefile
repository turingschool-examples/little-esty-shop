# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :csv_load do
  desc "load customer csv"
  task :customers do
    puts 'customers'
  end
  desc "load invoice_items csv"
  task :invoice_items do
    puts 'invoice_items'
  end
  desc "load invoices csv"
  task :invoices do
    puts 'invoices'
  end
  desc "load items csv"
  task :items do
    puts 'items'
  end
  desc "load merchants csv"
  task :merchants do
    puts 'merchants'
  end
  desc "load transactions csv"
  task :transactions do
    puts 'transactions'
  end
  desc 'run all csv files'
  task all: %W(customers invoice_items invoices items merchants transactions) do
    puts 'all'
  end
end