require 'csv'

namespace :csv_load do

  desc "loads customer CSV data into database"
  task customers:[:environment] do
      file = 'db/data/customers.csv'

    CSV.foreach(file, :headers => true) do |row|
      Customer.create!(
        id: row[0],
        first_name: row[1],
        last_name: row[2],
        created_at: row[3],
        updated_at: row[4]
      )
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end
end
