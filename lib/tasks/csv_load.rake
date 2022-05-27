require 'csv'

namespace :csv_load do
  desc "imports the customers csv into seed file"
  task customers: :environment do
    # reset primary key
    csv_text = File.read(Rails.root.join('db', 'data', 'customers.csv'))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Customer.create!(row.to_hash)
    end
  end

  desc "imports the invoice items csv into seed file"
  task invoice_items: :environment do
    p 'hello again'
  end

end

# id,first_name,last_name,created_at,updated_at
