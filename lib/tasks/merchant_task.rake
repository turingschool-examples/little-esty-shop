require 'csv'

namespace :csv_load do

  desc "loads merchant CSV data into database"
  task merchants:[:environment] do
      file = 'db/data/merchants.csv'

    CSV.foreach(file, :headers => true) do |row|
      Merchant.create!(
        id: row[0],
        name: row[1],
        created_at: row[2],
        updated_at: row[3]
      )
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end
end
