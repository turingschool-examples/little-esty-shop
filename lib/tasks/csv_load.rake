require 'csv'

def load_from_csv(table_name, model)
  csv_text = File.read("db/data/#{table_name}.csv")
  csv = CSV.parse(csv_text, headers: true)
  csv.each do |row|
    model.create!(row.to_hash)
  end
  ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
end

namespace :csv_load do
  desc "Load customers from CSV"
  task customers: :environment do
    load_from_csv('customers', Customer)
  end

  desc "Load invoice_items from CSV"
  task invoice_items: :environment do
    load_from_csv('invoice_items', InvoiceItem)
  end

  desc "Load invoices from CSV"
  task invoices: :environment do
    load_from_csv('invoices', Invoice)
  end

  desc "Load items from CSV"
  task items: :environment do
    load_from_csv('items', Item)
  end

  desc "Load merchants from CSV"
  task merchants: :environment do
    load_from_csv('merchants', Merchant)
  end

  desc "Load transactions from CSV"
  task transactions: :environment do
    load_from_csv('transactions', Transaction)
  end

  desc "Load all from CSV"
  task all: :environment do
    Rake::Task["csv_load:customers"].invoke
    Rake::Task["csv_load:merchants"].invoke
    Rake::Task["csv_load:items"].invoke
    Rake::Task["csv_load:invoices"].invoke
    Rake::Task["csv_load:invoice_items"].invoke
    Rake::Task["csv_load:transactions"].invoke
  end
end
