require 'csv'

namespace :csv_load do

  desc "loads transaction CSV data into database"
  task transactions:[:environment] do
      file = 'db/data/transactions.csv'

    CSV.foreach(file, :headers => true) do |row|
      Transaction.create!(
        id: row[0],
        invoice_id: row[1],
        credit_card_number: row[2],
        result: row[4],
        created_at: row[5],
        updated_at: row[6]
      )
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end
end
