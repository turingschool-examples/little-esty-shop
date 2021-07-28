require 'csv'

namespace :csv_load do

  desc 'Import customers from CSV'
  task customers: :environment do
    Customer.destroy_all
    file_path = "db/data/customers.csv"
    CSV.foreach(file_path, {headers: true, header_converters: :symbol}) do |row|
      Customer.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  desc 'Import invoice_items from CSV'
  task invoice_items: :environment do
    InvoiceItem.destroy_all
    file_path = "db/data/invoice_items.csv"
    CSV.foreach(file_path, {headers: true, header_converters: :symbol}) do |row|
      if row[:status] == 'pending'
        status = 0
      elsif row[:status] == 'packaged'
        status = 1
      elsif row[:status] == 'shipped'
        status = 2
      end
      InvoiceItem.create!(
        id: row[:id],
        item_id: row[:item_id],
        invoice_id: row[:invoice_id],
        quantity: row[:quantity],
        unit_price: row[:unit_price],
        status: status,
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  desc 'Import invoices from CSV'
  task invoices: :environment do
    Invoice.destroy_all
    file_path = "db/data/invoices.csv"
    CSV.foreach(file_path, {headers: true, header_converters: :symbol}) do |row|
      if row[:status] == 'in progress'
        status = 0
      elsif row[:status] == 'completed'
        status = 1
      elsif row[:status] == 'cancelled'
        status = 2
      end
      Invoice.create!(
        id: row[:id],
        customer_id: row[:customer_id],
        status: status,
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  desc 'Import items from CSV'
  task items: :environment do
    Item.destroy_all
    file_path = "db/data/items.csv"
    CSV.foreach(file_path, {headers: true, header_converters: :symbol}) do |row|
      Item.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  desc 'Import merchants from CSV'
  task merchants: :environment do
    Merchant.destroy_all
    file_path = "db/data/merchants.csv"
    CSV.foreach(file_path, {headers: true, header_converters: :symbol}) do |row|
      Merchant.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  desc 'Import transactions from CSV'
  task transactions: :environment do
    Transaction.destroy_all
    file_path = "db/data/transactions.csv"
    CSV.foreach(file_path, {headers: true, header_converters: :symbol}) do |row|
      Transaction.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  desc 'Import all CSV files at once'
  task all: :environment do
    Rake::Task["csv_load:customers"].invoke
    Rake::Task["csv_load:invoice_items"].invoke
    Rake::Task["csv_load:invoices"].invoke
    Rake::Task["csv_load:items"].invoke
    Rake::Task["csv_load:merchants"].invoke
    Rake::Task["csv_load:transactions"].invoke
  end
end
