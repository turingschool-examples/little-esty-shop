require 'csv'

namespace :csv_load do
  
  desc "Read CSV File Items"
  task items: :environment do
    items = Rails.root.join("db", "data", "items.csv")

    CSV.foreach(items, headers: true) do |item|
      Item.create!(item.to_hash)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end
end