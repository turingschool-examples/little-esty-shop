require 'csv'

namespace :csv_load do

  desc "loads items CSV data into database"
  task items:[:environment] do
      file = 'db/data/items.csv'

    CSV.foreach(file, :headers => true) do |row|
      Item.create!(
        id: row[0],
        name: row[1],
        description: row[2],
        unit_price: row[3],
        merchant_id: row[4],
        created_at: row[5],
        updated_at: row[6]
      )
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end
end
