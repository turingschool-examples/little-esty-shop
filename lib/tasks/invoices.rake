require 'csv'

namespace :csv_load do
  
  desc "Read CSV File Invoices"
  task invoices: :environment do
    invoices = Rails.root.join("db", "data", "invoices.csv")

    CSV.foreach(invoices, headers: true) do |invoice|
      invoice_hash = invoice.to_hash
      case invoice_hash["status"]
      when "cancelled"
        invoice_hash["status"] = 0
      when "completed"
        invoice_hash["status"] = 1
      when "in progress"
        invoice_hash["status"] = 2
      end
      Invoice.create!(invoice_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end
end