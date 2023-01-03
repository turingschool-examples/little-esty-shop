require 'csv'

namespace :csv_load do
  desc 'load invoice csv into db'
  task invoices:[:environment] do
    
    file = 'db/data/invoices.csv'
    
    CSV.foreach(file, headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
    
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice')
  end
end