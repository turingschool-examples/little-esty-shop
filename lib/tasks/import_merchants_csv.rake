require 'csv'
namespace :import_merchants_csv do
  task merchants: :environment do
    csv_text = File.read('...')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Merchant.create!(row.to_hash)
    end  
  end
end 
