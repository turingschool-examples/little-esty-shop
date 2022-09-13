require "csv"

namespace(:csv_load) do
  desc("This task loads a customers csv to the seed file")

  task(customers: :environment) do
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    CSV.foreach(Rails.root.join("db/data/customers.csv"),     headers: true) do |row|
      Customer.create!({id: row[0], first_name: row[1], last_name: row[2]})
    end
  end

  desc("This task loads a invoice_items csv to the seed file")

  task(  invoice_items: :environment) do
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    CSV.foreach(Rails.root.join("db/data/invoice_items.csv"),     headers: true) do |row|

      InvoiceItem.create!({
        id: row[0],
        item_id: row[1],
        invoice_id: row[2],
        quantity: row[3],
        unit_price: row[4],
        status: row[5],
      })
    end
  end

  desc("This task loads a invoices csv to the seed file")

  task(  invoices: :environment) do
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    CSV.foreach(Rails.root.join("db/data/invoices.csv"),     headers: true) do |row|

      Invoice.create!({
        id: row[0], 
        customer_id: row[1], 
        status: row[2]})
    end
  end

  task items: :environment do
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    CSV.foreach Rails.root.join("db/data/items.csv"), headers: true do |row|

      Item.create!({
        id: row[0],
        name: row[1],
        description: row[2],
        unit_price: row[3],
        merchant_id: row[5],
      })
    end
  end

  desc("This task loads a merchant csv to the seed file")
  task(merchants: :environment) do
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    CSV.foreach(Rails.root.join("db/data/merchants.csv"), headers: true) do |row|
      Merchant.create!({id: row[0], name: row[1]})
    end
  end

  desc("This task loads a transaction csv to the seed file")
  task(transactions: :environment) do
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    CSV.foreach(Rails.root.join("db/data/transactions.csv"), headers: true) do |row|
      
    Transaction.create!({id: row[0], invoice_id: row[1], credit_card_number: row[2], credit_card_expiration_date: row[3], result: row[4]})
    end
  end

  desc("This task loads all csv files to the seed file")
  task all: [:customers, :invoice_items, :invoices, :items, :merchants, :transactions] do
    
  end
end
