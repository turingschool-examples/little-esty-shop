require 'csv'

namespace :csv_load do

  desc "loads invoice CSV data into database"
  task invoices:[:environment] do
      file = 'db/data/invoices.csv'

    CSV.foreach(file, :headers => true) do |row|
      Invoice.create!(
        id: row[0],
        customer_id: row[1],
        status: row[2].gsub(" ","_").to_sym,
        created_at: row[3],
        updated_at: row[4]
      )
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end
end
