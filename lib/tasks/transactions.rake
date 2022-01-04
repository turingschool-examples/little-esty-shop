namespace :csv_load do
  desc 'rake import data from transaction csv files'
  task transaction_data: :environment do
    require 'csv'
    CSV.foreach('db/data/transactions.csv', headers: true) do |row|
      Customer.create!(row.to_hash)
    end

    table = 'transactions'
    max_id = (Transaction.last.id += 1)
    ActiveRecord::Base.connection.execute(
      "ALTER SEQUENCE #{table}_id_seq RESTART WITH #{max_id}"
    )
  end
end
