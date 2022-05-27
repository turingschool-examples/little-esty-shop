require 'csv'

namespace :csv_load do
  task all: %i[customers merchants items invoices invoice_items transactions]

  desc 'imports the customers csv into seed file'
  task customers: :environment do
    # reset primary key
    csv_text = File.read(Rails.root.join('db', 'data', 'customers.csv'))
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Customer.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  desc 'imports the invoice items csv into seed file'
  task invoice_items: :environment do
    # reset primary key
    csv_text = File.read(Rails.root.join('db', 'data', 'invoice_items.csv'))
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      InvoiceItem.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  desc 'imports the customers csv into seed file'
  task invoices: :environment do
    # reset primary key
    csv_text = File.read(Rails.root.join('db', 'data', 'invoices.csv'))
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Invoice.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  desc 'imports the customers csv into seed file'
  task items: :environment do
    # reset primary key
    csv_text = File.read(Rails.root.join('db', 'data', 'items.csv'))
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Item.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  desc 'imports the merchants csv into seed file'
  task merchants: :environment do
    # reset primary key
    csv_text = File.read(Rails.root.join('db', 'data', 'merchants.csv'))
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Merchant.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  desc 'imports the customers csv into seed file'
  task transactions: :environment do
    # reset primary key
    csv_text = File.read(Rails.root.join('db', 'data', 'transactions.csv'))
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Transaction.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end
end
