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
		CSV.foreach('db/data/customers.csv', headers: true) do |row|
      binding.pry
			Customer.create!(uuid: row["id"], first_name: row["first_name"], last_name: row["last_name"], created_at: row["created_at"], updated_at: row["updated_at"])
		end
	end

  task :invoice_items => [:environment] do
		CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
			InvoiceItem.create!(uuid: row["id"], item_id: row["item_id"], invoice_id: row["invoice_id"], quantity: row["quantity"], unit_price: row["unit_price"], status: row["status"], created_at: row["created_at"], updated_at: row["updated_at"])
		end
	end

	task :all => [:environment] do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
		Rake::Task['csv_load:customers'].execute
		Rake::Task['csv_load:invoice_items'].execute
		# Rake::Task['csv_load:invoices'].execute
		# Rake::Task['csv_load:items'].execute
		# Rake::Task['csv_load:merchants'].execute
		# Rake::Task['csv_load:transactions'].execute
	end
end
