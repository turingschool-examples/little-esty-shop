require 'csv'

namespace :csv_load do
  desc "Import items from csv file"
  task :items => :environment do
    CSV.foreach("db/data/items.csv", headers: true) do |row|
      Item.find_or_create_by!(id: row['id']) do |item|
        item.name = row['name']
        item.description = row['description']
        item.unit_price = row['unit_price'].to_i/100
        item.merchant_id = row['merchant_id']
      end
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end
end