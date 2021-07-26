require 'csv'

namespace :csv_load do
  desc "Imports a Customer CSV file into an ActiveRecord table"
  task :transactions => :environment do
      file = './db/data/transactions.csv'
      CSV.foreach(file, :headers => true) do |row|
        Transaction.create!({
                          :invoice_id => row[1],
                          :credit_card_number => row[2],
                          :credit_card_expiration_date => row[3],
                          :result => row[4],
                          :created_at => row[5],
                          :updated_at => row[6]
                          })
      end
  end
end
