require 'csv'

namespace :csv_load do
  desc 'This task loads data for the items'
  task items: [:environment] do
    file = Rails.root.join('db', 'data', 'items.csv')
    csv_text = File.read(file)
    csv = CSV.parse(csv_text.scrub, headers: true)
    csv.each do |row|
      t = Item.new
      t.id = row['id']
      t.merchant_id = row['merchant_id']
      t.name = row['name']
      t.description = row['description']
      t.unit_price = row['unit_price']
      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end
end