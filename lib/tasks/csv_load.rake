namespace :csv_load do

  task customers: :environment do
    require 'csv'
    csv_text = File.read(Rails.root.join("db", "data", "customers.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      t = Customer.new
      t.id = row['id']
      t.first_name = row['first_name']
      t.last_name = row['last_name']
      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  task invoice_items: :environment do
    require 'csv'
    csv_text = File.read(Rails.root.join("db", "data", "invoice_items.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      t = InvoiceItem.new
      t.id = row['id']
      t.invoice_id = row['invoice_id']
      t.item_id = row['item_id']
      t.quantity = row['quantity']
      t.unit_price = row['unit_price']
      if row['status'] == 'packaged'
        t.status = 0
      elsif row['status'] == 'pending'
        t.status = 1
      elsif row['status'] == 'shipped'
        t.status = 2
      end
      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  task invoices: :environment do
    require 'csv'
    csv_text = File.read(Rails.root.join("db", "data", "invoices.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      t = Invoice.new
      t.id = row['id']
      t.customer_id = row['customer_id']
      if row['status'] == 'cancelled'
        t.status = 0
      elsif row['status'] == 'completed'
        t.status = 1
      elsif row['status'] == 'in progress'
        t.status = 2
      end
      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  task items: :environment do
    require 'csv'
    csv_text = File.read(Rails.root.join("db", "data", "items.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      t = Item.new
      t.id = row['id']
      t.name = row['name']
      t.description = row['description']
      t.unit_price = row['unit_price']
      t.merchant_id = row['merchant_id']
      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  task merchants: :environment do
    require 'csv'
    csv_text = File.read(Rails.root.join("db", "data", "merchants.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      t = Merchant.new
      t.id = row['id']
      t.name = row['name']
      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  task transactions: :environment do
    require 'csv'
    csv_text = File.read(Rails.root.join("db", "data", "transactions.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      t = Transaction.new
      t.id = row['id']
      t.invoice_id = row['invoice_id']
      t.credit_card_number = row['credit_card_number']
      t.credit_card_expiration_date = row['credit_card_expiration_date']
      t.result = row['result']
      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  task pk_reset: :environment do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end

  task all: [:customers, :merchants, :invoices, :items, :invoice_items, :transactions, :pk_reset] do
  end
end