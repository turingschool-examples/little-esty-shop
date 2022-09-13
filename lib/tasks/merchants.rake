require 'csv'

namespace :csv_load do
  
  desc "Read CSV File Merchants"
  task merchants: :environment do
    merchants = Rails.root.join("db", "data", "merchants.csv")

    CSV.foreach(merchants, headers: true) do |merchant|
      Merchant.create!(merchant.to_hash)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end
end