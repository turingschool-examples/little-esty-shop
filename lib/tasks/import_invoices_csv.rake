require 'csv'

namespace :csv_load do
  desc "Import invoices from csv file"
  task :invoices => :environment do
    CSV.foreach("db/data/invoices.csv", headers: true) do |row|
      Invoice.find_or_create_by!(id: row['id']) do |invoice|
        invoice.status = row['status']
        invoice.customer_id = row['customer_id']
      end
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end
end