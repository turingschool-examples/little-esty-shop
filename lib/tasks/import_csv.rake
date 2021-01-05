require 'csv'
namespace :csv_load do

desc "load customers"
    task :customers => :environment do
        CSV.foreach("db/data/customers.csv", headers: true) do |row|
            Customer.create!(row.to_hash)
            # {
            # :id => row[1],
            # :first_name => row[2],
            # :last_name => row[4],
            # }
        end
    end
end


#   desc "load invoice_items"
#   task :invoice_items => :environment do
#     CSV.foreach(invoice_items, headers: true) do |row|
# 	invoice_items.create!(row.to_hash)
#     end
#   end

#   desc "load invoices"
#   task :invoices => :environment do
#     CSV.foreach(invoices, headers: true) do |row|
# 	invoices.create!(row.to_hash)
#     end
#   end

#   desc "load items"
#   task :items => :environment do
#     CSV.foreach(items, headers: true) do |row|
# 	items.create!(row.to_hash)
#     end
#   end

#   desc "load merchants"
#   task :merchants => :environment do
#     CSV.foreach(merchants, headers: true) do |row|
# 	merchants.create!(row.to_hash)
#     end
#   end

#   desc "load transactions"
#   task :transactions => :environment do
#     CSV.foreach(transactions, headers: true) do |row|
# 	transactions.create!(row.to_hash)
#     end
#   end

#   desc "load all"
# 	task all: [ :customers, :invoice_items, :invoices, :items, :merchants, :transactions]
# 	Rake::Task["all"].invoke
# 	end
#   end
	
# end