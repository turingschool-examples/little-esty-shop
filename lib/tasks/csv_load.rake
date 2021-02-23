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
  		ii[:unit_price] = row["unit_price"]
  		ii[:status] = row["status"]
  		ii.save
  	end
  end

  task invoices: :environment do

  	csv_text = File.read(Rails.root.join("db","data","invoices.csv"))
  	csv = CSV.parse(csv_text, :headers => true)
  	csv.each do |row|
  		invoice = Invoice.new
  		invoice[:status] = row["status"]
  		invoice.save
  	end
  end

end
