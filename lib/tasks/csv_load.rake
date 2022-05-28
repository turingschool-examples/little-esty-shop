require 'csv'

namespace :csv_load do
  desc 'TODO'
  task customers: :environment do
    CSV.foreach('db/data/customers.csv', headers: true) do |row|                                 # For now I just did it for the one im doing so you can see what I did and get some hands on
      Customer.create(row.to_h)                                                                  # with it yourself. Eventually we will move this into a method so it doesnt have to be repeated.
    end
  end

  desc 'TODO'
  task invoice_items: :environment do
  end

  desc 'TODO'
  task invoices: :environment do
    CSV.foreach('db/data/invoices.csv', headers: true) do |row|                                 # For now I just did it for the one im doing so you can see what I did and get some hands on
      Invoice.create(row.to_h) 
    end
  end

  desc 'TODO'
  task items: :environment do
    CSV.foreach('db/data/items.csv', headers: true) do |row|                                 # For now I just did it for the one im doing so you can see what I did and get some hands on
      Item.create(row.to_h)   
    end 
  end

  desc 'TODO'
  task merchants: :environment do
    CSV.foreach('db/data/merchants.csv', headers: true) do |row|                                 # For now I just did it for the one im doing so you can see what I did and get some hands on
      Merchant.create(row.to_h)                                                                  # with it yourself. Eventually we will move this into a method so it doesnt have to be repeated.
    end
  end

  desc 'TODO'
  task transactions: :environment do
    CSV.foreach('db/data/transactions.csv', headers: true) do |row|                                 # For now I just did it for the one im doing so you can see what I did and get some hands on
      Transaction.create(row.to_h)                                                                  # with it yourself. Eventually we will move this into a method so it doesnt have to be repeated.
    end                                                                                             # But for now its cool to see how it works
  end

  desc 'seed from all csv files'
  task all: %i[customers merchants items invoices invoice_items transactions]              # This is just for the :all, it says "run every one of these >> []"
end
