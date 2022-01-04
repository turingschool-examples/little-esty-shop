require 'csv'

desc "Import transactions from CSV"
task :import_transactions_csv => [:environment] do
  file = "db/data/transactions.csv"

  CSV.foreach(file, :headers => true) do |row|

    id = row[0],
    invoice_id = row[1],
    credit_card_number = row[2],
    credit_card_expiration_date = row[3],
    result = row[4]
    created_at = row[5]
    updated_at = row[6]
  Transaction.create!(id: id,
                      invoice_id: invoice_id,
                      credit_card_number: credit_card_number,
                      credit_card_expiration_date: credit_card_expiration_date,
                      result: result,
                      created_at: created_at,
                      updated_at: updated_at)
  end
  ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
end
