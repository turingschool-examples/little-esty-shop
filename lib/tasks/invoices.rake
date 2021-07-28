require 'csv'

namespace :csv_load do
  desc "Load Invoices CSV"
  task invoices: :environment do
    Invoice.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!(:invoices)
    csv_path = 'db/data/invoices.csv'
    csv = CSV.open(csv_path, headers: true)
    csv.each do |row|
      Invoice.create!(customer_id: row['customer_id'], status: row['status'])
    end
  end
end
