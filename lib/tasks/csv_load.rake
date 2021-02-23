require 'csv'

namespace :csv_load do |csv_load_namespace|
  desc "Import customers from customer.csv"
  task :customers => [:environment] do

    customer_file = File.join Rails.root, "db/data/customers.csv"

    CSV.foreach(customer_file, headers: true) do |row|
      Customer.create(
        first_name: row[1],
        last_name: row[2],
        created_at: row[3],
        updated_at: row[4]
      )
    end
  end

  desc "Import invoices from invoices.csv"
  task :invoices => [:environment] do

    invoices_file = File.join Rails.root, "db/data/invoices.csv"

    CSV.foreach(invoices_file, headers: true) do |row|
      Invoice.create(
        customer_id: row[1],
        status: row[2],
        created_at: row[3],
        updated_at: row[4]
      )
    end
  end

  desc "Import merchants from merchants.csv"
  task :merchants => [:environment] do

    merchants_file = File.join Rails.root, "db/data/merchants.csv"

    CSV.foreach(merchants_file, headers: true) do |row|
      Merchant.create(
        name: row[1],
        created_at: row[2],
        updated_at: row[3]
      )
    end
  end

  desc "Import items from items.csv"
  task :items => [:environment] do

    items_file = File.join Rails.root, "db/data/items.csv"

    CSV.foreach(items_file, headers: true) do |row|
      Item.create(
        name: row[1],
        description: row[2],
        unit_price: row[3],
        merchant_id: row[4],
        created_at: row[5],
        updated_at: row[6]
      )
    end
  end


  desc "Import from transactions.csv"
  task :transactions => [:environment] do

    transactions_file = File.join Rails.root, "db/data/transactions.csv"

    CSV.foreach(transactions_file, headers: true) do |row|
      Transaction.create(
        invoice_id: row[1],
        credit_card_number: row[2],
        credit_card_expiration_date: row[3],
        result: row[4],
        created_at: row[5],
        updated_at: row[6]
      )
    end
  end

  desc "Import invoice items from invoice_items.csv"
  task :invoice_items => [:environment] do

    invoice_items_file = File.join Rails.root, "db/data/invoice_items.csv"

    CSV.foreach(invoice_items_file, headers: true) do |row|
      InvoiceItem.create(
        item_id: row[1],
        invoice_id: row[2],
        quantity: row[3],
        unit_price: row[4],
        status: row[5],
        created_at: row[6],
        updated_at: row[7]
      )
    end
  end

  task :all => [:customers,
                :invoices,
                :merchants,
                :transactions,
                :items,
                :invoice_items]
end

  desc "csv_load_all_csv_files"
  task :csv_load => ["csv_load:all"]
