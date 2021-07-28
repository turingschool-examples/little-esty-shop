require 'csv'

namespace :csv_load do
  desc "Load Items CSV"
  task items: :environment do
    # Item.destroy_all
    csv_path = 'db/data/items.csv'
    csv = CSV.open(csv_path, headers: true)
    csv.each do |row|
      Item.create!(name: row['name'], description: row['description'], unit_price: row['unit_price'], merchant_id: row['merchant_id'])
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:items)
  end
end
