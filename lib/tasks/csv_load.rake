require "csv"
namespace :csv_load do
  desc "TODO"
  task customers: :environment do


  	csv_text = File.read(Rails.root.join("db","data","customers.csv"))
  	csv = CSV.parse(csv_text, :headers => true)
  	csv.each do |row|
  		c = Customer.new
  		c[:id] = row["id"]
  		c[:first_name] = row["first_name"]
  		c[:last_name]  = row["last_name"]
  		c[:created_at] = row["created_at"].to_datetime
  		c[:updated_at] = row["updated_at"].to_datetime
  		c.save
  	end
  end

  task invoice_items: :environment do

  	csv_text = File.read(Rails.root.join("db","data","invoice_items.csv"))
  	csv = CSV.parse(csv_text, :headers => true)
  	csv.each do |row|
  		ii = InvoiceItem.new
  		ii[:quantity] = row["quantity"]
      ii[:item_id] = row["item_id"]
      ii[:invoice_id] = row["invoice_id"]
  		ii[:unit_price] = row["unit_price"]
  		ii[:status] = row["status"]
  		ii.save!
  	end
  end

  task invoices: :environment do
    Invoice.destroy_all
  	csv_text = File.read(Rails.root.join("db","data","invoices.csv"))
  	csv = CSV.parse(csv_text, :headers => true)
  	csv.each do |row|
  		invoice = Invoice.new
      invoice[:customer_id] = row["customer_id"]
  		invoice[:status] = row["status"]
  		invoice.save
  	end
  end

  task all: :environment do
    Item.destroy_all
    Transaction.destroy_all
    Invoice.destroy_all
    InvoiceItem.destroy_all
    Customer.destroy_all
    Merchant.destroy_all

    csv_text = File.read(Rails.root.join("db","data","merchants.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      m = Merchant.new
      m.id = row["id"]
      m.name = row["name"]
      m.created_at = row["created_at"].to_datetime
      m.updated_at = row["updated_at"].to_datetime
      m.save
    end

    csv_text = File.read(Rails.root.join("db","data","customers.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      c = Customer.new
      c[:id] = row["id"]
      c[:first_name] = row["first_name"]
      c[:last_name]  = row["last_name"]
      c[:created_at] = row["created_at"].to_datetime
      c[:updated_at] = row["updated_at"].to_datetime
      c.save
    end

    csv_text = File.read(Rails.root.join("db","data","invoices.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      invoice = Invoice.new
      invoice[:id] = row["id"]
      invoice[:customer_id] = row["customer_id"]
      invoice[:status] = row["status"]
      invoice[:created_at] = row["created_at"].to_datetime
      invoice[:updated_at] = row["updated_at"].to_datetime
      invoice.save
    end

    csv_text = File.read(Rails.root.join("db","data","items.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      i = Item.new
      i.id = row["id"]
      i.name = row["name"]
      i.description = row["description"]
      i.unit_price = row["unit_price"]
      i.created_at = row["created_at"].to_datetime
      i.updated_at = row["updated_at"].to_datetime
      i.merchant_id = row["merchant_id"]
      i.save!
    end

    csv_text = File.read(Rails.root.join("db","data","transactions.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      t = Transaction.new
      t.id = row["id"]
      t.invoice_id = row["invoice_id"]
      t.credit_card_number = row["credit_card_number"].to_s
      t.credit_card_expiration_date = row["credit_card_expiration_date"]
      t.result = row["result"]
      t.created_at = row["created_at"].to_datetime
      t.updated_at = row["updated_at"].to_datetime
      t.save
    end

    csv_text = File.read(Rails.root.join("db","data","invoice_items.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      ii = InvoiceItem.new
      ii[:id] = row["id"]
      ii[:invoice_id] = row["invoice_id"]
      ii[:item_id] = row["item_id"]
      ii[:quantity] = row["quantity"]
      ii[:unit_price] = row["unit_price"]
      ii[:status] = row["status"]
      ii[:created_at] = row["created_at"].to_datetime
      ii[:updated_at] = row["updated_at"].to_datetime
      ii.save
    end
  end

end
