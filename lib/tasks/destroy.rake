require 'csv'

namespace :csv_load do
  desc "Destroy CSV files"
  task destroy: :environment do
    InvoiceItem.destroy_all
    Item.destroy_all
    Transaction.destroy_all
    Invoice.destroy_all
    Merchant.destroy_all
    Customer.destroy_all
  end
end
