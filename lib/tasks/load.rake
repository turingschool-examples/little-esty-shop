require 'csv'

namespace :csv_load do
  desc "This task loads a customers csv to the seed file"
  task customers: :environment  do
    CSV.foreach(Rails.root.join('db/data/customers.csv'), headers: true) do |row|
    Customer.create!({
      id: row[0],
      first_name: row[1],
      last_name: row[2]})
    end
  end
  
  desc "This task loads a invoice_items csv to the seed file"
  task invoice_items: :environment do
    CSV.foreach(Rails.root.join('db/data/invoice_items.csv'), headers: true) do |row|
      # ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
      InvoiceItem.create!({
        id: row[0],
        item_id: row[1],
        invoice_id: row[2],
        quantity: row[3],
        unit_price: row[4],
        status: row[5]})
      end
  end

  # desc ""
  # task do
  # end
end
