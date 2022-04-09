require 'require_all'

desc 'Say hello!'
namespace :csv_load do

  require_all './app/models'
  require 'csv'

  task customers: :environment do
    csv_text = File.read(Rails.root.join('db', 'data', 'customers.csv'))
    csv = CSV.parse(csv_text, :headers => true)

    # Customer.destroy_all

    csv.each do |row|
      # c = Customer.new
      # c.id = row["id"]
      # c.first_name = row["first_name"]
      # c.last_name = row["last_name"]
      # c.created_at = row["created_at"]
      # c.updated_at = row["updated_at"]
      # c.save
      #
      # puts "#{c.first_name} #{c.last_name} saved"
      puts "#{row["first_name"]} #{row["last_name"]} saved"
    end
  end

  task invoice_items: :environment do
    csv_text = File.read(Rails.root.join('db', 'data', 'invoice_items.csv'))
    csv = CSV.parse(csv_text, :headers => true)

    # InvoiceItem.destroy_all

    csv.each do |row|
      # ii = InvoiceItem.new
      # ii.id = row["id"]
      # ii.item_id = row["item_id"]
      # ii.invoice_id = row["invoice_id"]
      # ii.quantity = row["quantity"]
      # ii.unit_price = row["unit_price"]
      # ii.status = row["status"]
      # ii.created_at = row["created_at"]
      # ii.updated_at = row["updated_at"]
      # ii.save
      #
      # puts "Invoice Item ##{ii.id} saved"
      puts "Invoice Item ##{row["id"]} saved"
    end
  end

  task invoices: :environment do
    csv_text = File.read(Rails.root.join('db', 'data', 'invoices.csv'))
    csv = CSV.parse(csv_text, :headers => true)

    # Invoice.destroy_all

    csv.each do |row|
      # i = Invoice.new
      # i.id = row["id"]
      # i.customer_id = row["customer_id"]
      # i.status = row["status"]
      # i.created_at = row["created_at"]
      # i.updated_at = row["updated_at"]
      # i.save

      # puts "Invoice ##{i.id} saved"
      puts "Invoice ##{row["id"]} saved"
    end
  end

  task items: :environment do
    csv_text = File.read(Rails.root.join('db', 'data', 'items.csv'))
    csv = CSV.parse(csv_text, :headers => true)

    # Item.destroy_all

    csv.each do |row|
      # it = Item.new
      # it.id = row["id"]
      # it.name = row["name"]
      # it.description = row["description"]
      # it.unit_price = row["unit_price"]
      # it.merchant_id = row["merchant_id"]
      # it.created_at = row["created_at"]
      # it.updated_at = row["updated_at"]
      # it.save
      #
      # puts "#{it.name} saved"
      puts "#{row["name"]} saved"
    end
  end

  task merchants: :environment do
    csv_text = File.read(Rails.root.join('db', 'data', 'merchants.csv'))
    csv = CSV.parse(csv_text, :headers => true)

    # Merchant.destroy_all

    csv.each do |row|
      # m = Merchant.new
      # m.id = row["id"]
      # m.name = row["name"]
      # m.created_at = row["created_at"]
      # m.updated_at = row["updated_at"]
      # m.save
      #
      # puts "Merchant #{m.name} save"
      puts "Merchant #{row["name"]} save"
    end
  end

  task transactions: :environment do
    csv_text = File.read(Rails.root.join('db', 'data', 'transactions.csv'))
    csv = CSV.parse(csv_text, :headers => true)

    # Transaction.destroy_all

    csv.each do |row|
      # t = Transaction.new
      # t.id = row["id"]
      # t.invoice_id = row["invoice_id"]
      # t.credit_card_number = row["credit_card_number"]
      # t.credit_card_expiration_date = row["credit_card_expiration_date"]
      # t.result = row["result"]
      # t.created_at = row["created_at"]
      # t.updated_at = row["updated_at"]
      # t.save
      #
      # puts "Transaction for card ending in #{t.credit_card_number[-4..-1]} saved"
      puts "Transaction for card ending in #{row["credit_card_number"][-4..-1]} saved"
    end
  end

  task :all do
    system("rake csv_load:customers")
    sleep(1)
    system("rake csv_load:invoice_items")
    sleep(1)
    system("rake csv_load:invoices")
    sleep(1)
    system("rake csv_load:items")
    sleep(1)
    system("rake csv_load:merchants")
    sleep(1)
    system("rake csv_load:transactions")
    sleep(1)
  end

end
