namespace :csv_load do
  
  desc 'rake import data from merchant csv file'

  task merchants: :environment do
    require 'csv'
    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_hash)
    end

    table = 'merchants'
    first_id = (Merchant.last.id += 1)
    ActiveRecord::Base.connection.execute(
      "ALTER SEQUENCE #{table}_id_seq RESTART WITH #{first_id}"
    )
  end
end
