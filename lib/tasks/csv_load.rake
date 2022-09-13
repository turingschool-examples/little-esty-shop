require 'csv'
namespace :csv_load do
  desc 'customers'
  task :customers => :environment do

    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!({
        id:  row[0],
        first_name: row[1],
        last_name: row[2],
        created_at: row[3],
        updated_at: row[4]
      })
    end
  end

  desc 'invoice items'
  task :invoice_items => :environment do

    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!({
        id:  row[0],
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

  desc 'invoices'
  task :invoices => :environment do

    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create!({
        id:  row[0],
        customer_id: row[1],
        status: row[2],
        created_at: row[3],
        updated_at: row[4]
      })
    end
  end

  desc 'items'
  task :items => :environment do

    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create!({
        id:  row[0],
        name: row[1],
        description: row[2],
        unit_price: row[3],
        merchant_id: row[4],
        created_at: row[5],
        updated_at: row[6]
      })
    end
  end

  desc 'merchants'
  task :merchants => :environment do

    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!({
        id:  row[0],
        name: row[1],
        created_at: row[2],
        updated_at: row[3]
      })
    end
  end

  desc 'transactions'
  task :transactions => :environment do

    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create!({
        id:  row[0],
        invoice_id: row[1],
        credit_card_number: row[2],
        credit_card_expiration_date: row[3],
        result: row[4],
        created_at: row[5],
        updated_at: row[6]
      })
    end
  end

  desc "Scorched Earth"
  task :pk_reset => :environment do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end

  desc "csv load all"
  task :all => [:customers, :invoices, :merchants, :items, :transactions, :invoice_items, :pk_reset]
end
