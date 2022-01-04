require 'csv'

desc 'Import merchants from csv'
task :import_csv => [:environment] do

  file = "db/data/merchants.csv"

  CSV.foreach(file, :headers => true) do |row|
    id = row[0],
    name = row[1],
    created_at = row[2],
    updated_at = row[3]

    Merchant.create!(id: id,
                    name: name,
                    created_at: created_at,
                    updated_at: updated_at)
  end
  ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
end

desc "Import items from csv"
task :import_csv => [:environment] do
  file = "db/data/items.csv"

  CSV.foreach(file, :headers => true) do |row|

      id = row[0],
      name = row[1],
      description = row[2],
      unit_price = row[3],
      merchant_id = row[4]
      created_at = row[5]
      updated_at = row[6]

      Item.create!(id: id,
                      name: name,
                      description: description,
                      unit_price: unit_price,
                      merchant_id: merchant_id,
                      created_at: created_at,
                      updated_at: updated_at,
                      status: 0)

  end

  ActiveRecord::Base.connection.reset_pk_sequence!('items')
end


desc "Import customers from csv"
task :import_csv => [:environment] do

  file = "db/data/customers.csv"

  CSV.foreach(file, :headers => true) do |row|

      id = row[0],
      first_name = row[1],
      last_name = row[2],
      created_at = row[3],
      updated_at = row[4]

      Customer.create!(id: id,
                      first_name: first_name,
                      last_name: last_name,
                      created_at: created_at,
                      updated_at: updated_at)

  end

  ActiveRecord::Base.connection.reset_pk_sequence!('customers')
end


desc "Import invoices from csv"
task :import_csv => [:environment] do
  file = "db/data/invoices.csv"

  CSV.foreach(file, :headers => true) do |row|

      id = row[0],
      customer_id = row[1],
      status = row[2],
      created_at = row[3],
      updated_at = row[4]

      Invoice.create!(id: id,
                      customer_id: customer_id,
                      status: status,
                      created_at: created_at,
                      updated_at: updated_at)

  end

  ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
end

desc "Import invoice_items from csv"
task :import_csv => [:environment] do
  file = "db/data/invoice_items.csv"

  CSV.foreach(file, :headers => true) do |row|

      id = row[0],
      item_id = row[1],
      invoice_id = row[2],
      quantity = row[3],
      unit_price = row[4]
      status = row[5]
      created_at = row[6]
      updated_at = row[7]

      InvoiceItem.create!(id: id,
                      item_id: item_id,
                      invoice_id: invoice_id,
                      quantity: quantity,
                      unit_price: unit_price,
                      status: status,
                      created_at: created_at,
                      updated_at: updated_at)

  end

  ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
end


desc "Import transactions from CSV"
task :import_csv => [:environment] do
  file = "db/data/transactions.csv"

  CSV.foreach(file, :headers => true) do |row|

    id = row[0],
    invoice_id = row[1],
    credit_card_number = row[2],
    credit_card_expiration_date = row[3],
    result = row[4]
    created_at = row[5]
    updated_at = row[6]
  Transaction.create!(id: id,
                      invoice_id: invoice_id,
                      credit_card_number: credit_card_number,
                      credit_card_expiration_date: credit_card_expiration_date,
                      result: result,
                      created_at: created_at,
                      updated_at: updated_at)
  end
  ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
end
