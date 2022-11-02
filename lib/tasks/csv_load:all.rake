require 'csv'

namespace :csv_load do
  desc 'loads all data'
  task all: [:environment, :merchants, :customers, :invoices, :transactions, :items, :invoice_items] do
    p 'All data loaded'
  end
end
