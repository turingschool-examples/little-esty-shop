require 'csv'

def importCSV(path, model)
  CSV.foreach(path, :headers => true) do |row|
    model.constantize.create!(row.to_hash)
  end
end

namespace :csv_load do
  desc "Imports merchants csv file into database"
  task :merchants => [:environment] do
    file = "db/data/merchants.csv"
    importCSV(file, 'Merchant')
  end

  desc "Imports customers csv file into database"
  task :customers => [:environment] do
    file_path = "db/data/customers.csv"
    importCSV(file_path, 'Customer')
  end

  desc "Imports items csv file into database"
  task :items => [:environment] do
    file_path = "db/data/items.csv"
    importCSV(file_path, 'Item')
  end

  desc "Imports invoices csv file into database"
  task :invoices => [:environment] do
    file_path = "db/data/invoices.csv"
    importCSV(file_path, 'Invoice')
  end

  desc "Imports transactions csv file into database"
  task :transactions => [:environment] do
    file_path = "db/data/transactions.csv"
    importCSV(file_path, 'Transaction')
  end

  desc "Imports invoice items csv file into database"
  task :invoice_items => [:environment] do
    file_path = "db/data/invoice_items.csv"
    importCSV(file_path, 'InvoiceItem')
  end

  desc "Imports all csv files into database"
  task :all do
    tables = ['merchants', 'customers', 'invoices', 'transactions', 'items', 'invoice_items']
    tables.each do |table|
      Rake::Task["csv_load:#{table}"].invoke
    end
  end
end

# desc "Imports all csv files into the database"
# task :csv_load_all => [:environment] do
#
#   table_names.each do |name|
#     Rake::Task["csv_load"].invoke(name)
#     Rake::Task["csv_load"].reenable
#   end
# end
