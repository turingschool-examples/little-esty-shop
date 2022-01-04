namespace :csv_load do
  desc 'rake import data from customer csv files'
  task customer_data: :environment do
    require 'csv'
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_hash)
    end

    table = 'customers'
    first_id = (Customer.last.id += 1)
    ActiveRecord::Base.connection.execute(
      "ALTER SEQUENCE #{table}_id_seq RESTART WITH #{first_id}"
    )
  end
end
