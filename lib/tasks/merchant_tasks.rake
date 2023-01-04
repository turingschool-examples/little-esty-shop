require 'csv'

namespace :csv_load do
  desc 'loads merchant CSV into db'
  task :merchants do

    file = 'db/data/merchants.csv'

    CSV.foreach(file, headers: true) do |row|
      Merchant.create!(row.to_hash)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end
end