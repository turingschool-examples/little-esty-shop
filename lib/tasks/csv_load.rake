require 'csv'

namespace :csv_load do
  desc "imports merchants from csv file"
  task :merchants => :environment do
    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
    status_value = case row['status']
    when 'enabled'
      0 
    when 'disabled'
      1 
    else 
      nil 
    end
      Merchant.create!(name: row['name'], created_at: row['created_at'], updated_at: row['updated_at'], uuid: row['id'])
    end
  end

  desc "imports customers from csv file"
  task :customers => :environment do
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create!(first_name: row['first_name'], last_name: row['last_name'], created_at: row['created_at'], updated_at: row['updated_at'], uuid: row['id'])
    end
  end

  desc "imports inovices from CSV file"
  task :invoices => :environment do 
    CSV.foreach('db/data/invoices.csv', headers:true) do |row|
      status_value = case row['status'] 
      when 'in progress'
        0 
      when 'completed'
        1 
      when 'cancelled'
        2
      else 
        nil 
      end 
      Invoice.create!(status: status_value, created_at: row['created_at'], updated_at: row['updated_at'], uuid: row['id'], customer_id: row['customer_id'])
    end
  end

  desc "imports transactions from csv file"
  task :transactions => :environment do 
    CSV.foreach('db/data/transactions.csv', headers: true) do |row|
      status_value = case row['result'] 
      when 'success'
        0 
      when 'failed'
        1          
      else 
        nil 
      end 
      Transaction.create!(credit_card_number: row['credit_card_number'], credit_card_expiration_date: row['credit_card_expiration_date'], result: row['result']== 'success' ? 0 : 1, invoice_id: row['invoice_id'], created_at: row['created_at'], updated_at: row['updated_at'], uuid: row['id'])
    end
  end

  desc "imports items from csv file"
  task :items => :environment do
    CSV.foreach('db/data/items.csv', headers: true) do |row|
      status_value = case row['status']
      when 'disabled'
        0 
      when 'enabled'
        1 
      else 
        nil 
      end
      Item.create!(name: row['name'], description: row['description'], unit_price: row['unit_price'], merchant_id: row['merchant_id'], created_at: row['created_at'], updated_at: row['updated_at'], uuid: row['id'])
    end
  end
  
  desc "imports invoice items from csv file"
  task :invoice_items => :environment do
    CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
      status_value = case row['status'] 
      when 'pending'
        0 
      when 'packaged'
        1     
      when 'shipped'
        2
      else 
        nil 
      end 
      InvoiceItem.create!(item_id: row['item_id'], invoice_id: row['invoice_id'], quantity: row['quantity'], unit_price: row['unit_price'], status: row['status'], created_at: row['created_at'], updated_at: row['updated_at'], uuid: row['id'])
    end
  end

  desc 'all csv files'
  task :all => :environment do
    ActiveRecord::Base.connection.reset_pk_sequence!('all')
    Rake::Task["csv_load:merchants"].execute
    Rake::Task["csv_load:customers"].execute
    Rake::Task["csv_load:invoices"].execute
    Rake::Task["csv_load:transactions"].execute
    Rake::Task["csv_load:items"].execute
    Rake::Task["csv_load:invoice_items"].execute
  end
end
