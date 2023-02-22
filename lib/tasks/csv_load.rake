require 'csv'

namespace :csv_load do
desc "This task loads csv data"
  task :customers => :environment do
    CSV.foreach('././db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  task :merchants => :environment do
    CSV.foreach('././db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end
  
  task :invoices => :environment do
    CSV.foreach('././db/data/invoices.csv', headers: true) do |row|
      r = row.to_h
      if r['status'] == 'cancelled'
        r['status'] = 0
      elsif r['status'] == 'in progress'
        r['status'] = 1
      elsif r['status'] == 'completed'
        r['status'] = 2
      end
      Invoice.create!(r)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  task :items => :environment do
    CSV.foreach('././db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  task :invoice_items => :environment do
    CSV.foreach('././db/data/invoice_items.csv', headers: true) do |row|
      r = row.to_h
      if r['status'] == 'pending'
        r['status'] = 0
      elsif r['status'] == 'packaged'
        r['status'] = 1
      elsif r['status'] == 'shipped'
        r['status'] = 2
      end
      InvoiceItem.create!(r)    
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  task :transactions => :environment do
    CSV.foreach('././db/data/transactions.csv', headers: true) do |row|
      r = row.to_h
      if r['result'] == 'failed'
        r['result'] = 0
      elsif r['result'] == 'success'
        r['result'] = 1
      end
      Transaction.create!(r)                          
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  task :all => :environment do
    Rake::Task['csv_load:customers'].execute
    Rake::Task['csv_load:merchants'].execute
    Rake::Task['csv_load:items'].execute
    Rake::Task['csv_load:invoices'].execute
    Rake::Task['csv_load:invoice_items'].execute
    Rake::Task['csv_load:transactions'].execute
  end
end