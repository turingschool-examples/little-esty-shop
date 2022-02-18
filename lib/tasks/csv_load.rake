require 'csv'

namespace :csv_load do
  desc "load transaction csv"
  task transaction_load: :environment do
    load_csv(Transaction, "transactions")
  end

  desc "load item csv"
  task item_load: :environment do
    load_csv(Item, "items")
  end

  desc "load merchant csv"
  task merchant_load: :environment do
    load_csv(Merchant, "merchants")
  end

  desc "load invoice_items csv"
  task invoice_items_load: :environment do
    load_csv(InvoiceItem, "invoice_items")
  end

  desc "load customer csv"
  task customer_load: :environment do
    load_csv(Customer, "customers")
  end

  desc "load invoice csv"
  task invoice_load: :environment do
    load_csv(Invoice, "invoices")
  end

  desc "import all csv"
  task all: :environment do
    load_csv(Merchant, "merchants")
    load_csv(Customer, "customers")
    load_csv(Item, "items")
    load_csv(Invoice, "invoices")
    load_csv(InvoiceItem, "invoice_items")
    load_csv(Transaction, "transactions")
  end
end

def load_csv(class_variable, link_variable)
  CSV.foreach("db/data/#{link_variable}.csv", headers: true) do |row|
    class_variable.create(row.to_h)
    ActiveRecord::Base.connection.reset_pk_sequence!(link_variable)
  end
end
