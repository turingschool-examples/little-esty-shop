namespace :csv_load do
  desc 'calls all listed csv rake tasks'
  task all:[:customers, :merchants]
end