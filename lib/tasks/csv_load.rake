require 'csv'
require 'rake'

namespace :csv_load do
  desc "load merchant database"
  task :merchants => [:environment] do
    Merchant.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    file = CSV.readlines('./db/data/merchants.csv', headers: true, header_converters: :symbol)
    file.each do |row|
      row.delete(:id)
      Merchant.create!(row.to_h)
    end
  end

  desc "load customer database"
  task :customers => [:environment] do
    Customer.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    file = CSV.readlines('./db/data/customers.csv', headers: true, header_converters: :symbol)
    file.each do |row|
      row.delete(:id)
      Customer.create!(row.to_h)
    end
  end

  desc "load invoice database"
  task :invoices => [:environment] do
    Invoice.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    file = CSV.readlines('./db/data/invoices.csv', headers: true, header_converters: :symbol)
    file.each do |row|
      row.delete(:id)
      Invoice.create!(row.to_h)
    end
  end

  desc "load transaction database"
  task :transactions => [:environment] do
    Transaction.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    file = CSV.readlines('./db/data/transactions.csv', headers: true, header_converters: :symbol)
    file.each do |row|
      row.delete(:id)
      Transaction.create!(row.to_h)
    end
  end

  desc "load item database"
  task :items => [:environment] do
    Item.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    file = CSV.readlines('./db/data/items.csv', headers: true, header_converters: :symbol)
    file.each do |row|
      row.delete(:id)
      row[:unit_price] = row[:unit_price].to_i * 0.01
      Item.create!(row.to_h)
    end
  end

  desc "load invoice item database"
  task :invoice_items => [:environment] do
    InvoiceItem.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    file = CSV.readlines('./db/data/invoice_items.csv', headers: true, header_converters: :symbol)
    file.each do |row|
      row.delete(:id)
      row[:unit_price] = row[:unit_price].to_i * 0.01
      InvoiceItem.create!(row.to_h)
    end
  end
  desc "import all databases"
  task :all => [:merchants, :customers, :items, :invoices, :transactions, :invoice_items]
end
