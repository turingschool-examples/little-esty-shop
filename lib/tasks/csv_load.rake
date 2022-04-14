require 'csv'

namespace :csv_load do
  task :customers => :environment do
   file = "db/data/customers.csv"
    CSV.foreach(file, headers: true) do |row|
      customer_hash = row.to_hash
            customer = Customer.where(id: customer_hash["id"])
      if customer.count == 1
        customer.first.update_attributes(customer_hash)
      else
        Customer.create!(customer_hash)
      end
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end


  task :invoices => :environment do
   file = "db/data/invoices.csv"
    CSV.foreach(file, headers: true) do |row|
      invoice_hash = row.to_hash
      invoice = Invoice.where(id: invoice_hash["id"])
      if invoice.count == 1
        invoice.first.update_attributes(invoice_hash)
      else
        Invoice.create!(invoice_hash)
      end
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  task :merchants => :environment do
   file = "db/data/merchants.csv"
    CSV.foreach(file, headers: true) do |row|
      merchant_hash = row.to_hash
      merchant = Merchant.where(id: merchant_hash["id"])
      if merchant.count == 1
        merchant.first.update_attributes(merchant_hash)
      else
        Merchant.create!(merchant_hash)
      end
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  task :items => :environment do
   file = "db/data/items.csv"
    CSV.foreach(file, headers: true) do |row|
      item_hash = row.to_hash
      item = Item.where(id: item_hash["id"])
      if item.count == 1
        item.first.update_attributes(item_hash)
      else
        Item.create!(item_hash)
      end
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  task :transactions => :environment do
   file = "db/data/transactions.csv"
    CSV.foreach(file, headers: true) do |row|
      transaction_hash = row.to_hash
      transaction = Transaction.where(id: transaction_hash["id"])
      if transaction.count == 1
        transaction.first.update_attributes(transaction_hash)
      else
        Transaction.create!(transaction_hash)
      end
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  task :invoice_items => :environment do
    file = "db/data/invoice_items.csv"
    CSV.foreach(file, headers: true) do |row|
      invoice_items_hash = row.to_hash
      invoice_items = InvoiceItem.where(id: invoice_items_hash["id"])
      if invoice_items.count == 1
        invoice_items.first.update_attributes(invoice_items_hash)
      else
        InvoiceItem.create!(invoice_items_hash)
      end
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  task :all => [:customers, :invoices, :merchants, :items, :transactions, :invoice_items]
end
