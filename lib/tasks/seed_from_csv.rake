require "csv"

namespace :csv_load do
  desc "Seed data.csv from db/data to database table"
  task merchants: :environment do
    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
      Merchant.create!({
        name: row[1],
        created_at: row[2],
        updated_at: row[3]
        })
      end
      puts("Merchants imported")
    end

  task items: :environment do
    CSV.foreach('db/data/items.csv', headers: true) do |row|
      Item.create!({
        name: row[1],
        description: row[2],
        unit_price: row[3],
        merchant_id: row[4],
        created_at: row[5],
        updated_at: row[6]
        })
      end
      puts("Items imported")
    end

  task customers: :environment do
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create!(
        first_name: row[1],
        last_name: row[2],
        created_at: row[3],
        updated_at: row[4]
      )
    end
    puts("Customers imported")
  end

  task invoices: :environment do
    CSV.foreach('db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(
        customer_id: row[1],
        status: row[52],
        created_at: row[3],
        updated_at: row[4]
      )
    end
    puts("Invoice imported")
  end

  task invoice_items: :environment do
    CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(
        item_id: row[1],
        invoice_id: row[2],
        quantity: row[3],
        unit_price: row[4],
        status: row[5],
        created_at: row[6],
        updated_at: row[7]
      )
    end
    puts("InvoiceItems imported")
  end

  task transactions: :environment do
    CSV.foreach('db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(
        invoice_id: row[1],
        cc_number: row[2],
        cc_expiration_date: row[3],
        result: row[4],
        created_at: row[5],
        updated_at: row[6]
      )
    end
    puts("Transactions imported")
  end

  task all: :environment do
    Rake::Task['csv_load:merchants'].execute
    Rake::Task['csv_load:items'].execute
    Rake::Task['csv_load:customers'].execute
    Rake::Task['csv_load:invoices'].execute
    Rake::Task['csv_load:invoice_items'].execute
    Rake::Task['csv_load:transactions'].execute
  end
end
