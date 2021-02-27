require 'csv'
namespace :csv_load do
  desc "TODO"
  task merchants: :environment do
    csv_text = File.read(Rails.root.join("db","data","merchants.csv"))
  	csv = CSV.parse(csv_text, :headers => true)
  	csv.each do |row|
      m = Merchant.new
      m.id = row["id"]
      m.name = row["name"]
      m.created_at = row["created_at"]
      m.updated_at = row["updated_at"]
      m.save
    end
  end

end
