require 'csv'

namespace :csv_load do
  desc "load invoices data"
  task invoices: :environment do
    CSV.foreach('db/data/invoices.csv', :headers => true) do |row|
      Invoice.create!(row.to_hash)
    end
  end
end
