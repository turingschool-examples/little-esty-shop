require 'csv'

namespace :csv_load do
  desc 'loads transaction CSV into db'
  task :transactions do

    file = 'db/data/transactions.csv'

    CSV.foreach(file, headers: true) do |row|
      Transaction.create!(row.to_hash)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end
end