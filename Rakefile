# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'csv'

Rails.application.load_tasks

desc "Load and seed all CSV files"

# namespace :csv_load do
# 	task :customers => [:environment] do
# 		items = []
# 		CSV.foreach('db/data/customers.csv', headers: true) do |row|
# 			items << row.to_h
# 		end
# 		Customer.import(items)
# 	end
# end

# namespace :csv_load do
# 	task :customers => [:environment] do
# 		items = []
# 		CSV.foreach('db/data/customers.csv', headers: true) do |row|
# 			Customer.create!(row.to_h)
# 		end
# 	end
# end

namespace :csv_load do
	task :customers => [:environment] do
		items = []
		CSV.foreach('db/data/customers.csv', headers: true) do |row|
			Customer.create!(row.to_h)
		end
	end

	task :all => [:environment] do
		Rake::Task['csv_load:customers'].execute
		Rake::Task['csv_load:invoice_items'].execute
		Rake::Task['csv_load:invoices'].execute
		Rake::Task['csv_load:items'].execute
		Rake::Task['csv_load:merchants'].execute
		Rake::Task['csv_load:transactions'].execute
	end
end
