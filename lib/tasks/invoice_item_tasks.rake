require 'csv'

namespace :csv_load do
  desc 'loads invoice_items CSV into db'
	task :invoice_items do
    file = 'db/data/invoice_items.csv'
     
    CSV.foreach(file, headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
	end
end