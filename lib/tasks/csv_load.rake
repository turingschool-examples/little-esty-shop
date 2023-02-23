require 'csv'

namespace :csv_load do
  
  desc 'Import customers from csv file'
  task customers: :environment do 
    file = 'db/data/customers.csv'

    CSV.foreach(file, headers: :true) do |row| 
      Customer.create(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  desc 'Import invoices from csv file'
  task invoices: :environment do 
    file = 'db/data/invoices.csv'

    CSV.foreach(file, headers: :true) do |row| 
      Invoice.create(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end
  
  desc 'Import merchants from csv file'
  task merchants: :environment do 
    file = 'db/data/merchants.csv'

    CSV.foreach(file, headers: :true) do |row| 
      Merchant.create(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  desc 'Import items from csv file'
  task items: :environment do 
    file = 'db/data/items.csv'

    CSV.foreach(file, headers: :true) do |row| 
      Item.create(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  desc 'Import invoice items from csv file'
  task invoice_items: :environment do 
    file = 'db/data/invoice_items.csv'

    CSV.foreach(file, headers: :true) do |row| 
      InvoiceItem.create(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  desc 'Import transactions from csv file'
  task transactions: :environment do 
    file = 'db/data/transactions.csv'

    CSV.foreach(file, headers: :true) do |row| 
      Transaction.create(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  desc 'Run all tasks'
  task all: [:customers, :invoices, :merchants, :items, :invoice_items, :transactions]
  
# ActiveRecord::Base.connection.tables.each do |table|
#   ActiveRecord::Base.connection.reset_pk_sequence!(table)
# end

end
