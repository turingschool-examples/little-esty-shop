namespace :csv_load do
  require "csv"
  desc "TODO"

  task customers: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "customers.csv"))
    csv = CSV.parse(csv_text, :headers => true)

    csv.each do |row|
      Customer.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  task merchants: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "merchants.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Merchant.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  task items: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "items.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Item.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end
end
