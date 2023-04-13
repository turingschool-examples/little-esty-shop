require 'csv'

namespace :csv_load do
  desc "Import transactions from csv file"
  task :transactions => :environment do
    CSV.foreach("db/data/transactions.csv", headers: true) do |row|
      Transaction.find_or_create_by!(id: row['id']) do |transaction|
        transaction.credit_card_number = row['credit_card_number']
        transaction.credit_card_expiration_date = row['credit_card_expiration_date']
        transaction.result = row['result']
        transaction.invoice_id = row['invoice_id'] 
      end
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end
end