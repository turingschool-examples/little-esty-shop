namespace :csv_load do
  task transactions: :environment do
    Transaction.destroy_all
    csv.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_h)
    end
  end
end
