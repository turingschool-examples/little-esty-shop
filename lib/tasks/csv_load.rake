namespace :csv_load do
  desc "TODO"
  task customers: :environment do
    puts "customers"
  end

  task invoice_items: :environment do
    puts "invoice items"
  end

  task invoices: :environment do
    puts "invoices"
  end

  task items: :environment do
    puts "items"
  end

  task merchants: :environment do
    puts "merchants"
  end

  task transactions: :environment do
    puts "transactions"
  end

  desc 'Runs all other tasks'
  task :all => ["csv_load:customers", "csv_load:invoice_items", "csv_load:invoices", "csv_load:items", "csv_load:merchants", "csv_load:transactions"] do
  end
end
