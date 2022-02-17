
require 'csv'

desc "Imports a customer file into an ActiveRecord table"
task :customer, [:filename] => :environment do
  CSV.foreach('./db/data/customers.csv', :headers => true) do |row|
    Customer.create!(row.to_hash)
  end
  ActiveRecord::Base.connection.execute("ALTER SEQUENCE serial RESTART WITH #{Customer.maximum(:id)}")

end

desc "Imports an invoice_item file into an ActiveRecord table"
task :invoiceitem, [:filename] => :environment do
CSV.foreach('./db/data/invoice_items.csv', :headers => true) do |row|
  InvoiceItem.create!(row.to_hash)
  end
  ActiveRecord::Base.connection.execute("ALTER SEQUENCE serial RESTART WITH #{InvoiceItem.maximum(:id)}")
end

desc "Imports an invoice file into an ActiveRecord table"
task :invoice, [:filename] => :environment do
CSV.foreach('./db/data/invoices.csv', :headers => true) do |row|
  Invoice.create!(row.to_hash)
  end
  ActiveRecord::Base.connection.execute("ALTER SEQUENCE serial RESTART WITH #{Invoice.maximum(:id)}")
end

desc "Imports an merchants file into an ActiveRecord table"
task :merchant, [:filename] => :environment do
CSV.foreach('./db/data/merchants.csv', :headers => true) do |row|
  Merchant.create!(row.to_hash)
  end
  ActiveRecord::Base.connection.execute("ALTER SEQUENCE serial RESTART WITH #{Merchant.maximum(:id)}")
end

desc "Imports an item file into an ActiveRecord table"
task :item, [:filename] => :environment do
CSV.foreach('./db/data/items.csv', :headers => true) do |row|
  Item.create!(row.to_hash)
  end
  ActiveRecord::Base.connection.execute("ALTER SEQUENCE serial RESTART WITH #{Item.maximum(:id)}")
end

desc "Imports a transaction file into an ActiveRecord table"
task :transaction, [:filename] => :environment do
CSV.foreach('./db/data/transactions.csv', :headers => true) do |row|
  Transaction.create!(row.to_hash)
  end
  ActiveRecord::Base.connection.execute("ALTER SEQUENCE transaction_id_seq RESTART WITH #{Transaction.maximum(:id) + 1}")
end

desc "Import all in order"
task :all => [ :customer, :invoice, :transaction, :merchant, :item, :invoiceitem  ] # ordered appropriately.
