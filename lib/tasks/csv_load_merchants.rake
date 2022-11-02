require 'csv'

namespace :csv_load do
  desc 'This task loads data for the merchants'
  task merchants: [:environment] do
    file = Rails.root.join('db', 'data', 'merchants.csv')
    csv_text = File.read(file)
    csv = CSV.parse(csv_text.scrub, headers: true)
    csv.each do |row|
      t = Merchant.new
      t.id = row['id']
      t.name = row['name']
      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end
end