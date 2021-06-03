require 'csv'

namespace :csv do

  task load_customers: :environment do

    CSV.foreach(Rails.root.join('db/data/customers.csv'), headers: true) do |row|

      Customer.create({
                      id: row[0],
                      first_name: row[1],
                      last_name: row[2],
                      created_at: row[3],
                      updated_at: row[4]
                      })
    end
  end

  task load_invoice_items: :environment do

    CSV.foreach(Rails.root.join('db/data/invoice_items.csv'), headers: true) do |row|

      InvoiceItem.create({
                      id: row[0],
                      item_id: row[1],
                      invoice_id: row[2],
                      quantity: row[3],
                      unit_price: row[4],
                      status: row[5],
                      created_at: row[6],
                      updated_at: row[7]
                      })
    end
  end

  task load_invoices: :environment do

    CSV.foreach(Rails.root.join('db/data/invoices.csv'), headers: true) do |row|

      Invoice.create({
                      id: row[0],
                      customer_id: row[1],
                      status: row[2],
                      created_at: row[3],
                      updated_at: row[4]
                      })
    end
  end

  task load_items: :environment do

    CSV.foreach(Rails.root.join('db/data/items.csv'), headers: true) do |row|

      Item.create({
                      id: row[0],
                      name: row[1],
                      description: row[2],
                      unit_price: row[3],
                      merchant_id: row[4],
                      created_at: row[5],
                      updated_at: row[6]
                      })
    end
  end

  task load_merchants: :environment do

    CSV.foreach(Rails.root.join('db/data/merchants.csv'), headers: true) do |row|

      Merchant.create({
                      id: row[0],
                      name: row[1],
                      created_at: row[2],
                      updated_at: row[3]
                      })
    end
  end

  task load_transactions: :environment do

    CSV.foreach(Rails.root.join('db/data/transactions.csv'), headers: true) do |row|

      Transaction.create({
                      id: row[0],
                      invoice_id: row[1],
                      credit_card_number: row[2],
                      credit_card_expiration_date: row[3],
                      result: row[4],
                      created_at: row[5],
                      updated_at: row[6]
                      })
    end
  end

  task load_all: :environment do
    Rake::Task['csv:load_customers'].execute
    Rake::Task['csv:load_merchants'].execute
    Rake::Task['csv:load_items'].execute
    Rake::Task['csv:load_invoices'].execute
    Rake::Task['csv:load_transactions'].execute
    Rake::Task['csv:load_invoice_items'].execute
  end
end
