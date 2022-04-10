require 'csv'

namespace :csv_load do
  task :customers => :environment do
   file = "db/data/customers.csv"
    CSV.foreach(file, headers: true) do |row|
      customer_hash = row.to_hash
      customer = Customer.where(id: customer_hash["id"])
      if customer.count == 1
        customer.first.update_attributes(customer_hash)
      else
        Customer.create!(customer_hash)
      end
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  task :invoices => :environment do
   file = "db/data/invoices.csv"
    CSV.foreach(file, headers: true) do |row|
      invoice_hash = row.to_hash
      invoice = Invoice.where(id: invoice_hash["id"])
      if invoice.count == 1
        invoice.first.update_attributes(invoice_hash)
      else
        Invoice.create!(invoice_hash)
      end
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end
end
