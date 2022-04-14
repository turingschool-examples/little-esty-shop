require "require_all"
require_all "./app/models"
require "csv"

desc "Seed CSV data"
namespace :csv_load do
  task customers: :environment do
    csv_text = File.read(Rails.root.join("db", "data", "customers.csv"))
    csv = CSV.parse(csv_text, headers: true)

    csv.each do |row|
      c = Customer.new
      c.id = row["id"]
      c.first_name = row["first_name"]
      c.last_name = row["last_name"]
      c.created_at = row["created_at"]
      c.updated_at = row["updated_at"]
      c.save

      puts "#{c.first_name} #{c.last_name} saved"
    end
  end

  task invoice_items: :environment do
    csv_text = File.read(Rails.root.join("db", "data", "invoice_items.csv"))
    csv = CSV.parse(csv_text, headers: true)
    enums = {"pending" => "0", "packaged" => "1", "shipped" => "2"}

    csv.each do |row|
      ii = InvoiceItem.new
      ii.id = row["id"]
      ii.invoice_id = row["invoice_id"]
      ii.item_id = row["item_id"]
      ii.quantity = row["quantity"]
      ii.unit_price = row["unit_price"]
      ii.status = enums[row["status"]]
      ii.created_at = row["created_at"]
      ii.updated_at = row["updated_at"]
      ii.save

      puts "Invoice Item ##{ii.id} saved"
    end
  end

  task invoices: :environment do
    csv_text = File.read(Rails.root.join("db", "data", "invoices.csv"))
    csv = CSV.parse(csv_text, headers: true)
    enums = {"in progress" => "0", "completed" => "1", "cancelled" => "2"}

    csv.each do |row|
      i = Invoice.new
      i.id = row["id"]
      i.customer_id = row["customer_id"]
      i.status = enums[row["status"]]
      i.created_at = row["created_at"]
      i.updated_at = row["updated_at"]
      i.save

      puts "Invoice ##{i.id} saved"
    end
  end

  task items: :environment do
    csv_text = File.read(Rails.root.join("db", "data", "items.csv"))
    csv = CSV.parse(csv_text, headers: true)

    csv.each do |row|
      it = Item.new
      it.id = row["id"]
      it.name = row["name"]
      it.description = row["description"]
      it.unit_price = row["unit_price"]
      it.merchant_id = row["merchant_id"]
      it.created_at = row["created_at"]
      it.updated_at = row["updated_at"]
      it.status = 0
      it.save

      puts "#{it.name} saved"
    end
  end

  task merchants: :environment do
    csv_text = File.read(Rails.root.join("db", "data", "merchants.csv"))
    csv = CSV.parse(csv_text, headers: true)

    csv.each do |row|
      m = Merchant.new
      m.id = row["id"]
      m.name = row["name"]
      m.created_at = row["created_at"]
      m.updated_at = row["updated_at"]
      m.save

      puts "Merchant #{m.name} save"
    end
  end

  task transactions: :environment do
    csv_text = File.read(Rails.root.join("db", "data", "transactions.csv"))
    csv = CSV.parse(csv_text, headers: true)

    csv.each do |row|
      t = Transaction.new
      t.id = row["id"]
      t.invoice_id = row["invoice_id"]
      t.credit_card_number = row["credit_card_number"]
      t.result = row["result"]
      t.created_at = row["created_at"]
      t.updated_at = row["updated_at"]
      t.save

      puts "Transaction for card #{t.credit_card_number} saved"
    end
  end

  task all: :environment do
    InvoiceItem.destroy_all unless !InvoiceItem.first.present?
    Item.destroy_all unless !Item.first.present?
    Merchant.destroy_all unless !Merchant.first.present?
    Transaction.destroy_all unless !Transaction.first.present?
    Invoice.destroy_all unless !Invoice.first.present?
    Customer.destroy_all unless !Customer.first.present?

    system("rake csv_load:merchants")
    system("rake csv_load:items")
    system("rake csv_load:customers")
    system("rake csv_load:invoices")
    system("rake csv_load:invoice_items")
    system("rake csv_load:transactions")
  end
end
