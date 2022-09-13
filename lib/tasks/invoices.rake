require 'csv'

namespace :csv_load do
  
  desc "Read CSV File Invoices"
  task invoices: :environment do
    invoices = Rails.root.join("db", "data", "invoices.csv")

    CSV.foreach(invoices, headers: true) do |invoice|
      Invoice.create!(invoice.to_hash)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end
end