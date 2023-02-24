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
			Customer.create!(id: row[:id], first_name: row["first_name"], last_name: row["last_name"], created_at: row["created_at"], updated_at: row["updated_at"])
		end
		ActiveRecord::Base.connection.reset_pk_sequence!("customers")
		p 'Customers loaded successfully'
	end

  task :invoice_items => [:environment] do
		CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
			InvoiceItem.create!(id: row[:id], item_id: row["item_id"], invoice_id: row["invoice_id"], quantity: row["quantity"], unit_price: row["unit_price"], status: row["status"], created_at: row["created_at"], updated_at: row["updated_at"])
		end
		ActiveRecord::Base.connection.reset_pk_sequence!("invoice_items")
		p 'InvoiceItems loaded successfully'
	end
	 	
	task :invoices => [:environment] do
		CSV.foreach('db/data/invoices.csv', headers: true) do |row|
			Invoice.create!(id: row[:id], customer_id: row["customer_id"], status: row["status"], created_at: row["created_at"], updated_at: row["updated_at"])
		end
		ActiveRecord::Base.connection.reset_pk_sequence!("invoices")
		p 'Invoices loaded successfully'
	end

  task :items => [:environment] do
		CSV.foreach('db/data/items.csv', headers: true) do |row|
			Item.create!(id: row[:id], name: row["name"], description: row["description"], unit_price: row["unit_price"], merchant_id: row["merchant_id"], created_at: row["created_at"], updated_at: row["updated_at"])
		end
		ActiveRecord::Base.connection.reset_pk_sequence!("items")
		p 'Items loaded successfully'
	end

  task :merchants => [:environment] do
		CSV.foreach('db/data/merchants.csv', headers: true) do |row|
			Merchant.create!(id: row[:id], name: row["name"], created_at: row["created_at"], updated_at: row["updated_at"])
		end
		ActiveRecord::Base.connection.reset_pk_sequence!("merchants")
		p 'Merchants loaded successfully'
	end

  task :transactions => [:environment] do
		CSV.foreach('db/data/transactions.csv', headers: true) do |row|
			Transaction.create!(id: row[:id], invoice_id: row["invoice_id"], credit_card_number: row["credit_card_number"], credit_card_expiration_date: row["credit_card_expiration_date"], result: row["result"], created_at: row["created_at"], updated_at: row["updated_at"])
		end
		ActiveRecord::Base.connection.reset_pk_sequence!("transactions")
		p 'Transactions loaded successfully'
	end

	task :all => [:environment] do
		Rake::Task['csv_load:customers'].execute
		Rake::Task['csv_load:invoices'].execute
		Rake::Task['csv_load:merchants'].execute
    Rake::Task['csv_load:items'].execute
		Rake::Task['csv_load:invoice_items'].execute
		Rake::Task['csv_load:transactions'].execute
	end
end
