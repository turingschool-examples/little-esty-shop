
require 'csv'

namespace :import do

  desc "Import customers from CSV"
  task customer: :environment do
    filename = File.join Rails.root, "/db/data/customers.csv"
    CSV.foreach(filename, :headers => true) do |row|
      Customer.create!(row.to_h)
    end
  end

  # desc "Import invoice_items from CSV"
  # task invoice_items: :environment do
  #   filename = File.join Rails.root, "/db/data/invoice_items.csv"
  #   CSV.foreach(filename) do |row|
  #     p row
  #   end
  # end
end
