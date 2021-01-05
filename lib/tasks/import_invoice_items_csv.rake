require 'csv'
namespace :csv_load do
  task :invoice_items => :environment do
      csv_text = File.read('db/data/invoice_items.csv')
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end
end
