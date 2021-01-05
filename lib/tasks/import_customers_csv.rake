require 'csv'
namespace :csv_load do
  task :customers => :environment do
      csv_text = File.read('db/data/customers.csv')
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
      Customer.create!(row.to_hash)
    end
  end
end
