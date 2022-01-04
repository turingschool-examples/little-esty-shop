namespace :csv_load do

  desc 'rake import data from invoice_items csv file'

  task invoice_items: :environment do
    require 'csv'
    CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end

    table = 'invoice_items'
    first_id = (InvoiceItem.last.id += 1)
    ActiveRecord::Base.connection.execute(
      "ALTER SEQUENCE #{table}_id_seq RESTART WITH #{first_id}"
    )
  end
end
