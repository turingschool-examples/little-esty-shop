require 'csv'

namespace :csv_load do
  
  desc "Read CSV File Transactions"
  task transactions: :environment do
    transactions = Rails.root.join("db", "data", "transactions.csv")

    CSV.foreach(transactions, headers: true) do |transaction|
      Transaction.create!(transaction.to_hash)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end
end