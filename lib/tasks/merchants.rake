require 'csv'

namespace :csv_load do
  desc "Load Merchant CSV"
  task merchants: :environment do
    # Merchant.destroy_all
    csv_path = 'db/data/merchants.csv'
    csv = CSV.open(csv_path, headers: true)
    csv.each do |row|
      Merchant.create!(name: row['name'])
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:merchants)
  end
end
