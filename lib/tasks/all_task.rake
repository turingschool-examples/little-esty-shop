namespace :csv_load do

  desc "adds data to every table in the database"
  task all:[:environment, :customers, :merchants, :items, :invoices, :invoice_items, :transactions] do
  end
end
