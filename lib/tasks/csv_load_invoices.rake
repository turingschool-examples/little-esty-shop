require 'csv'

status_hash = {'completed' => 0, 'cancelled' => 1, 'in progress' => 2}

namespace :csv_load do
  desc 'This task loads data for the invoices'
  task invoices: [:environment] do
    file = Rails.root.join('db', 'data', 'invoices.csv')
    csv_text = File.read(file)
    csv = CSV.parse(csv_text.scrub, headers: true)
    csv.each do |row|
      t = Invoice.new
      t.id = row['id']
      t.customer_id = row['customer_id']
      t.status = status_hash[row['status']]
      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save!
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end
end