require 'csv'

def create_models_from_csv(path, model)
  CSV.foreach(path, headers: true) do |row|
    model.constantize.create!(row.to_h)
  end
end

namespace :csv_load do
  task customers: :environment do
    create_models_from_csv('./db/data/customers.csv', 'Customer')
  end

  task merchants: :environment do
    create_models_from_csv('./db/data/merchants.csv', 'Merchant')
  end

  task items: :environment do
    create_models_from_csv('./db/data/items.csv', 'Item')
  end

  task invoices: :environment do
    create_models_from_csv('./db/data/invoices.csv', 'Invoice')
  end

  task invoice_items: :environment do
    create_models_from_csv('./db/data/invoice_items.csv', 'InvoiceItem')
  end

  task transactions: :environment do
    create_models_from_csv('./db/data/transactions.csv', 'Transaction')
  end

  task :all do
    tables = ['customers', 'merchants', 'items',
              'invoices', 'invoice_items', 'transactions']
    tables.each do |t|
      Rake::Task["csv_load:#{t}"].invoke
    end
  end
#   task :all do
#     tables = ["customers"]
#     tables.each do |table|
#       Rake::Task["csv_load:#{table}"].invoke
#       ActiveRecord::Base.connection.reset_pk_sequence!(table)
#     end
#   end
end
