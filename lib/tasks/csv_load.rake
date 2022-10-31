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
end

# Your project will include a Rake task for each of the six csv files
# rails csv_load:invoice_items
# rails csv_load:invoices
# rails csv_load:items
# rails csv_load:merchants
# rails csv_load:transactions