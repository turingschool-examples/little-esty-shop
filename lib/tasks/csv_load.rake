require 'csv'

namespace :csv_load do
  
  desc "Seed db with csv customers"
  task customers: :environment do
    Customer.destroy_all
    CSV.foreach('./db/data/customers.csv', headers: true, header_converters: :symbol) do |row|
      binding.pry
      Customer.create!(row.to_hash)
    end
  end

  desc "Seed db with csv invoice_items"
  task invoices: :environment do
  end

  desc "Seed db with csv invoices"
  task items: :environment do
  end

  desc "Seed db with csv items"
  task merchants: :environment do
  end

  desc "Seed db with csv merchants"
  task transactions: :environment do
  end

  desc "Seed db with csv transactions"
  task invoice_items: :environment do
  end
end
