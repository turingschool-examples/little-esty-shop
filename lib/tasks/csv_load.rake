require 'csv'



namespace :csv_load do
  task :merchants => :environment do
    Merchant.destroy_all
    # binding.pry
    CSV.foreach("db/data/merchants.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
      Merchant.create!(row.to_hash)
    end
  end
end
