require 'csv'

namespace :csv_load do
  desc "Imports Transaction CSV file into an ActiveRecord table"
  task :transactions => :environment do
    Transaction.destroy_all
    file = './db/data/transactions.csv'
    CSV.foreach(file, :headers => true) do |row|
        Transaction.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:transactions)
  end
end
