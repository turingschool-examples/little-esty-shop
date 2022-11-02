require 'csv'

namespace :csv_load do
  desc 'This task loads data for the customers'
  task customers: [:environment] do
    file = Rails.root.join('db', 'data', 'customers.csv')
    csv_text = File.read(file)
    csv = CSV.parse(csv_text.scrub, headers: true)
    csv.each do |row|
      t = Customer.new
      t.first_name = row['first_name']
      t.last_name = row['last_name']
      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save
    end 
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end
end