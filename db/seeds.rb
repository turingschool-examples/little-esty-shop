require 'csv'

# customers data
CSV.foreach("db/data/customers.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  Customer.create(row.to_hash)
end

# invoice_items data
CSV.foreach("db/data/invoice_items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  InvoiceItem.create(row.to_hash)
end

# invoices data
CSV.foreach("db/data/invoices.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  Invoice.create(row.to_hash)
end

# items data
CSV.foreach("db/data/items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  Item.create(row.to_hash)
end

# merchants data
CSV.foreach("db/data/merchants.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  Merchant.create(row.to_hash)
end

# transactions data
CSV.foreach("db/data/transactions.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  Transaction.create(row.to_hash)
end
