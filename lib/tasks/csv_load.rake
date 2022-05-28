require 'csv'



namespace :csv_load do
  task merchants: :environment do
    Merchant.destroy_all
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create(row.to_h)
    end
      ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end
  
  task customers: :environment do
    Customer.destroy_all
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create(row.to_h)
    end
      ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  task items: :environment do
    Item.destroy_all
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create(row.to_h)
    end
      ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  task invoice_items: :environment do
    InvoiceItem.destroy_all
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
        if row[5] == "packaged"
        row[5] = 0
        elsif row[5] == "pending"
          row[5] = 1
        else row[5] == "shipped"
          row[5] = 2
        end
      InvoiceItem.create(row.to_h)
    end
      ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  task invoices: :environment do
    Invoice.destroy_all
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
       if row[2] == "cancelled"
        row[2] = 0
        elsif row[2] == "in progress"
          row[2] = 1
        else row[2] == "completed"
          row[2] = 2
        end
      Invoice.create(row.to_h)
    end
      ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end



  task transactions: :environment do
    Transaction.destroy_all
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create(row.to_h)
    end
      ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  task all: :environment do
    Rake::Task["csv_load:merchants"].invoke
    Rake::Task["csv_load:customers"].invoke
    Rake::Task["csv_load:items"].invoke
    Rake::Task["csv_load:invoices"].invoke
    Rake::Task["csv_load:transactions"].invoke
    Rake::Task["csv_load:invoice_items"].invoke
  end

end
