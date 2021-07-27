require 'csv'

namespace :csv_load do
  desc "Imports Customer CSV file into an ActiveRecord table"
  task :customers => :environment do
      file = './db/data/customers.csv'
      CSV.foreach(file, :headers => true) do |row|
        Customer.create!({
                          :first_name => row[1],
                          :last_name => row[2],
                          :created_at => row[3],
                          :updated_at => row[4]
                          })
      end
  end
end
