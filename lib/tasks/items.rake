namespace :csv_load do

  desc 'rake import data from item csv file'

  task items: :environment do
    require 'csv'
    CSV.foreach('db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_hash)
    end

    table = 'items'
    first_id = (Item.last.id += 1)
    ActiveRecord::Base.connection.execute(
      "ALTER SEQUENCE #{table}_id_seq RESTART WITH #{first_id}"
    )
  end
end
