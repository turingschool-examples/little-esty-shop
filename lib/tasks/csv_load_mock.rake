require 'csv'

namespace :csv_load_mock do
  desc 'All'
  task all: [:customers, :invoices, :merchants, :items, :transactions, :invoice_items]

  desc "Load customers CSV into DB"
  task customers: :environment do
    CSV.foreach(Rails.root.join('db/mock_data/customers.csv'), headers: true, :header_converters => :symbol) do |row|
      Customer.create!({id: row[:id], first_name: row[:first_name], last_name: row[:last_name], created_at: row[:created_at], updated_at: row[:updated_at]})
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('Customers')
    puts "Mock Seeded Customers Table"
    puts "==================================="
  end

  desc "Load invoices CSV into DB"
  task invoices: :environment do
    CSV.foreach(Rails.root.join('db/mock_data/invoices.csv'), headers: true, :header_converters => :symbol) do |row|
      status = {"in progress" => 0, "completed" => 1, "cancelled" => 2}

      Invoice.create!({id: row[:id], customer_id: row[:customer_id], status: status[row[:status]], created_at: row[:created_at], updated_at: row[:updated_at]})
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('Invoices')
    puts "Mock Seeded Invoices Table"
    puts "==================================="
  end

  desc "Load merchants CSV into DB"
  task merchants: :environment do
    CSV.foreach(Rails.root.join('db/mock_data/merchants.csv'), headers: true, :header_converters => :symbol) do |row|
      Merchant.create!({id: row[:id], name: row[:name], created_at: row[:created_at], updated_at: row[:updated_at]})
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('Merchants')
    puts "Mock Seeded Merchants Table"
    puts "==================================="
  end

  desc "Load items CSV into DB"
  task items: :environment do
    CSV.foreach(Rails.root.join('db/mock_data/items.csv'), headers: true, :header_converters => :symbol) do |row|
      Item.create!({id: row[:id], name: row[:name], description: row[:description], unit_price: row[:unit_price], merchant_id: row[:merchant_id], created_at: row[:created_at], updated_at: row[:updated_at]})
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('Items')
    puts "Mock Seeded Items Table"
    puts "==================================="
  end

  desc "Load transactions CSV into DB"
  task transactions: :environment do
    CSV.foreach(Rails.root.join('db/mock_data/transactions.csv'), headers: true, :header_converters => :symbol) do |row|
      status = {"success" => 0, "failed" => 1}

      Transaction.create!({id: row[:id], invoice_id: row[:invoice_id], credit_card_number: row[:credit_card_number], credit_card_expiration_date: row[:credit_card_expiration_date], result: status[row[:result]], created_at: row[:created_at], updated_at: row[:updated_at]})
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('Transactions')
    puts "Mock Seeded Transactions Table"
    puts "==================================="
  end

  desc "Load invoice_items CSV into DB"
  task invoice_items: :environment do
    CSV.foreach(Rails.root.join('db/mock_data/invoice_items.csv'), headers: true, :header_converters => :symbol) do |row|
      status = {"pending" => 0, "packaged" => 1, "shipped" => 2}

      InvoiceItem.create!({id: row[:id], item_id: row[:item_id], invoice_id: row[:invoice_id], quantity: row[:quantity], unit_price: row[:unit_price], status: status[row[:status]], created_at: row[:created_at], updated_at: row[:updated_at]})
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('Invoice_Items')
    puts "Mock Seeded Invoice_Items Table"
    puts "==================================="
  end
end
