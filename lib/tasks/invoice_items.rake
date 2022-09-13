require 'csv'

namespace :csv_load do
  
  desc "Read CSV File Invoice Items"
  task invoice_items: :environment do
    invoice_items = Rails.root.join("db", "data", "invoice_items.csv")

    CSV.foreach(invoice_items, headers: true) do |invoice_item|
      invoice_item_hash = invoice_item.to_h
      case invoice_item_hash["status"]
      when "pending"
        invoice_item_hash["status"] = 0
      when "packaged"
        invoice_item_hash["status"] = 1
      when "shipped"
        invoice_item_hash["status"] = 2
      end
      InvoiceItem.create!(invoice_item_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end
end