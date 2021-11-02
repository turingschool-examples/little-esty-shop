namespace :csv_load do
  task merchants: :environment do
    Merchant.destroy_all
    csv.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end
  end
end
