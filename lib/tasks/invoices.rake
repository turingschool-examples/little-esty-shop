namespace :csv_load do

  desc 'rake import data from invoice csv file'

  task invoices: :environment do
    require 'csv'
    CSV.foreach('db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_hash)
    end

    table = 'invoices'
    first_id = (Invoice.last.id += 1)
    ActiveRecord::Base.connection.execute(
      "ALTER SEQUENCE #{table}_id_seq RESTART WITH #{first_id}"
    )
  end
end
