require 'csv'

namespace :csv_load do
  
  desc "Read CSV File Transactions"
  task transactions: :environment do
    transactions = Rails.root.join("db", "data", "transactions.csv")

    CSV.foreach(transactions, headers: true) do |transaction|
      transaction_hash = transaction.to_h
      case transaction_hash["result"]
      when "failed"
        transaction_hash["result"] = 0
      when "success"
        transaction_hash["result"] = 1
      end
      Transaction.create!(transaction_hash)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end
end