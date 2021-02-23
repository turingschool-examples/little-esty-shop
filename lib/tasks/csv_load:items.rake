require 'csv'
namespace :csv_load do
  desc "TODO"
  task items: :environment do
    csv_text = File.read(Rails.root.join("db","data","items.csv"))
    	csv = CSV.parse(csv_text, :headers => true)
    	csv.each do |row|
        i = Item.new
        i.name = row["name"]
        i.description = row["description"]
        i.unit_price = row["unit_price"]
        i.created_at = row["created_at"]
        i.updated_at = row["updated_at"]
        i.merchant_id = row["merchant_id"]
        i.save
    end
  end
end
