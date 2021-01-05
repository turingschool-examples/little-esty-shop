require 'csv'
namespace :csv_load do
  task :transactions => :environment do
      csv_text = File.read('db/data/transactions.csv')
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
      Transaction.create!(row.to_hash)
    end
  end
end
