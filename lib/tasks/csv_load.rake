require 'csv'

namespace :csv_load do

  task customers: :environment do
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  task invoice_items: :environment do
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  task invoices: :environment do
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  task items: :environment do
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  task merchants: :environment do
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  task transactions: :environment do
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  task all: %i[customers merchants items invoices invoice_items transactions]
end