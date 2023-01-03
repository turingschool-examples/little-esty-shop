namespace :csv_load do
  desc 'calls all listed csv rake tasks'
  task all:[:environment, :customers, :merchants, :invoices, :items]
end