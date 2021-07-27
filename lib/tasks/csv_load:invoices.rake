require 'csv'

namespace :csv_load do
  desc "Imports Invoice CSV file into an ActiveRecord table"
  task :invoices => :environment do
      file = './db/data/invoices.csv'
      CSV.foreach(file, :headers => true) do |row|
        Invoices.create!({
                          :customer_id => row[1],
                          :status => row[2],
                          :created_at => row[3],
                          :updated_at => row[4]
                          })
      end
  end
end
