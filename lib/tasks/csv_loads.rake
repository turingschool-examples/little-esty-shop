require 'csv'

desc "Creates customers from a CSV."
task "csv_load:customers" => [ :environment ] do
  Customer.destroy_all
  CSV.foreach('db/data/customers.csv', headers: true) do |row|
    Customer.create!(row.to_h)
  end
end

desc "Creates merchants from a CSV."
task "csv_load:merchants" => [ :environment ] do
  Merchant.destroy_all
  CSV.foreach('db/data/merchants.csv', headers: true) do |row|
    Merchant.create!(row.to_h)
  end
end

desc "Creates items from a CSV."
task "csv_load:items" => [ :environment ] do
  Item.destroy_all
  CSV.foreach('db/data/items.csv', headers: true) do |row|
    Item.create!(row.to_h)
  end
end

desc "Creates invoices from a CSV."
task "csv_load:invoices" => [ :environment ] do
  Invoice.destroy_all
  CSV.foreach('db/data/invoices.csv', headers: true) do |row|
    Invoice.create!(row.to_h)
  end
end

desc "Creates transactions from a CSV."
task "csv_load:transactions" => [ :environment ] do
  Transaction.destroy_all
  CSV.foreach('db/data/transactions.csv', headers: true) do |row|
    Transaction.create!(row.to_h)
  end
end

desc "Creates invoice items from a CSV."
task "csv_load:invoice_items" => [ :environment ] do
  InvoiceItem.destroy_all
  CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
    InvoiceItem.create!(row.to_h)
  end
end

desc "Creates all from a CSV."
task "csv_load:all" do
  Rake::Task["csv_load:customers"].invoke
  Rake::Task["csv_load:merchants"].invoke
  Rake::Task["csv_load:items"].invoke
  Rake::Task["csv_load:invoices"].invoke
  Rake::Task["csv_load:transactions"].invoke
  Rake::Task["csv_load:invoice_items"].invoke
end




