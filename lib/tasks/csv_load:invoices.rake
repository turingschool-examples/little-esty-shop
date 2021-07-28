require 'csv'

namespace :csv_load do
  desc "Imports Invoice CSV file into an ActiveRecord table"
  task :invoices => :environment do
    Invoice.destroy_all
    file = './db/data/invoices.csv'
    CSV.foreach(file, :headers => true) do |row|
      Invoice.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:invoices)
  end
end
