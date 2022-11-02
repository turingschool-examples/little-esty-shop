require 'csv'

namespace :csv_load do
  desc 'One Task to rule them all, One Task to find them, One Task to bring them all and in the darkness bind them'
  task :one_task => [:merchants, :customers, :invoices, :transactions, :items, :invoice_items]
end