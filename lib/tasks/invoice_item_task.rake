require 'csv'

namespace :csv_load do

  desc "loads invoice items CSV data into database"
  task invoice_items:[:environment] do
      file = 'db/data/invoice_items.csv'

    CSV.foreach(file, :headers => true) do |row|
      InvoiceItem.create!(
        id: row[0],
        item_id: row[1],
        invoice_id: row[2],
        quantity: row[3],
        unit_price: row[4],
        status: row[5],
        created_at: row[6],
        updated_at: row[7]
      )
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end
end
