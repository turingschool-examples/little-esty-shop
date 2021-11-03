require 'csv'

def create_models_from_csv(path, model)
  CSV.foreach(path, headers: true) do |row|
    model.constantize.create!(row.to_h)
  end
end

namespace :csv_load do
  task customers: :environment do
    create_models_from_csv('./db/data/customers.csv', 'Customer')
    puts "Created #{Customer.count} customers"
  end

  task merchants: :environment do
    create_models_from_csv('./db/data/merchants.csv', 'Merchant')
    puts "Created #{Merchant.count} merchants"
  end

  task items: :environment do
    create_models_from_csv('./db/data/items.csv', 'Item')
    puts "Created #{Item.count} items"

  end

  task invoices: :environment do
    create_models_from_csv('./db/data/invoices.csv', 'Invoice')
    puts "Created #{Invoice.count} invoices"
  end

  task invoice_items: :environment do
    create_models_from_csv('./db/data/invoice_items.csv', 'InvoiceItem')
    puts "Created #{InvoiceItem.count} invoice items"
  end

  task transactions: :environment do
    create_models_from_csv('./db/data/transactions.csv', 'Transaction')
    puts "Created #{Transaction.count} transactions"
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
