namespace :csv_load do
  desc "TODO"
  task customers: :environment do
    path = "./db/data/customers.csv"
    file_data = File.read(path)
    csv = CSV.parse(file_data, :headers => true)

    csv.each do |row|
      Customer.create!(row.to_hash)
    end
  end

  task invoice_items: :environment do
    path = "./db/data/invoice_items.csv"
    file_data = File.read(path)
    csv = CSV.parse(file_data, :headers => true)

    csv.each do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  task invoices: :environment do
    path = "./db/data/invoices.csv"
    file_data = File.read(path)
    csv = CSV.parse(file_data, :headers => true)

    csv.each do |row|
      Invoice.create!(row.to_hash)
    end
  end


  task merchants: :environment do
    path = "./db/data/merchants.csv"
    file_data = File.read(path)
    csv = CSV.parse(file_data, :headers => true)

    csv.each do |row|
      Merchant.create!(row.to_hash)
    end
  end

  task items: :environment do
    path = "./db/data/items.csv"
    file_data = File.read(path)
    csv = CSV.parse(file_data, :headers => true)

    csv.each do |row|
      Item.create!(row.to_hash)
    end
  end

  task transactions: :environment do
    path = "./db/data/transactions.csv"
    file_data = File.read(path)
    csv = CSV.parse(file_data, :headers => true)

    csv.each do |row|
      Transaction.create!(row.to_hash)
    end
  end

  desc "Reset all Primary Keys"
  task reset_pks: :environment do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end

  desc "destroy all" do
    task destroy_all: :environment do
      Merchant.destroy_all
      Customer.destroy_all
      Transaction.destroy_all
      Item.destroy_all
      Invoice.destroy_all
      InvoiceItem.destroy_all
    end
  end

  desc 'Runs all other tasks'
    task :all => ["csv_load:destroy_all","csv_load:customers", "csv_load:invoices", "csv_load:merchants", "csv_load:items",  "csv_load:transactions", "csv_load:invoice_items", "csv_load:reset_pks"] do
  end
end
