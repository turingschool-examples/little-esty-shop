namespace :csv_load do
  desc 'rake import data from customer csv files'
  task customer_data: :environment do
    require 'csv'
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_hash)
    end

    table = 'customers'
    max_id = Customer.last.id
    ActiveRecord::Base.connection.execute(
      "ALTER SEQUENCE #{table}_id_seq RESTART WITH #{max_id}"
    )
  end
end
