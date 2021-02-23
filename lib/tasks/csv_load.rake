require 'csv'

namespace :csv_load do

  task customers: :environment do

    Customer.destroy_all

    file = File.read(Rails.root.join('db', 'data', 'customers.csv'))

    CSV.parse(file, headers: true) do |row|
      customer = Customer.new({
        id: row[0],
        first_name: row[1],
        last_name: row[2],
        created_at: row[3],
        updated_at: row[4]
        })
      customer.save
      p "#{customer.first_name} saved"
    end
    p "There are #{Customer.count} records in the customers table"
  end
end

namespace :csv_load do

  task invoice_items: :environment do

    InvoiceItem.destroy_all

    file = File.read(Rails.root.join('db', 'data', 'invoice_items.csv'))

    CSV.parse(file, headers: true) do |row|
      invoice_item = InvoiceItem.new({
        id: row[0],
        item_id: row[1],
        invoice_id: row[2],
        quantity: row[3],
        unit_price: row[4],
        status: row[5],
        created_at: row[6],
        updated_at: row[7]
        })
      invoice_item.save
      p "#{invoice_item.id} saved"
    end
    p "There are #{InvoiceItem.count} records in the invoice_items table"
  end
end

namespace :csv_load do

  task invoices: :environment do

    Invoice.destroy_all

    file = File.read(Rails.root.join('db', 'data', 'invoices.csv'))

    CSV.parse(file, headers: true) do |row|
      invoice = Invoice.new({
        id: row[0],
        customer_id: row[1],
        status: row[2],
        created_at: row[3],
        updated_at: row[4]
        })
        invoice.save
        p "#{invoice.id} saved"
    end
    p "There are #{Invoice.count} records in the invoices table"
  end
end

namespace :csv_load do

  task items: :environment do

    Item.destroy_all

    file = File.read(Rails.root.join('db', 'data', 'items.csv'))

    CSV.parse(file, headers: true) do |row|
      item = Item.new({
        id: row[0],
        name: row[1],
        description: row[2],
        unit_price: row[3],
        merchant_id: row[4],
        created_at: row[5],
        updated_at: row[6]
        })
        item.save
        p "#{item.name} saved"
    end
    p "There are #{Item.count} records in the items table"
  end
end

namespace :csv_load do

  task merchants: :environment do

    Merchant.destroy_all

    file = File.read(Rails.root.join('db', 'data', 'merchants.csv'))

    CSV.parse(file, headers: true) do |row|
      merchant = Merchant.new({
        id: row[0],
        name: row[1],
        created_at: row[2],
        updated_at: row[3]
        })
        merchant.save
        p "#{merchant.name} saved"
    end
    p "There are #{Merchant.count} records in the merchants table"
  end
end

namespace :csv_load do

  task transactions: :environment do

    Transaction.destroy_all

    file = File.read(Rails.root.join('db', 'data', 'transactions.csv'))

    CSV.parse(file, headers: true) do |row|
      transaction = Transaction.new({
        id: row[0],
        invoice_id: row[1],
        credit_card_number: row[2],
        credit_card_expiration_date: row[3],
        result: row[4],
        created_at: row[5],
        updated_at: row[6]
        })
        transaction.save
        p "#{transaction.id} saved"
    end
    p "There are #{Transaction.count} records in the transactions table"
  end
end

namespace :csv_load do

  task delete: :environment do

    InvoiceItem.destroy_all
    Transaction.destroy_all
    Invoice.destroy_all
    Customer.destroy_all
    Item.destroy_all
    Merchant.destroy_all

  end
end

namespace :csv_load do

  task all: :environment do

    InvoiceItem.destroy_all
    Invoice.destroy_all
    Customer.destroy_all
    Item.destroy_all
    Merchant.destroy_all
    Transaction.destroy_all

    file = File.read(Rails.root.join('db', 'data', 'customers.csv'))

    CSV.parse(file, headers: true) do |row|
      customer = Customer.new({
        id: row[0],
        first_name: row[1],
        last_name: row[2],
        created_at: row[3],
        updated_at: row[4]
        })
      customer.save
      p "#{customer.first_name} saved"
    end
    p "There are #{Customer.count} records in the customers table"

  file = File.read(Rails.root.join('db', 'data', 'invoices.csv'))

  CSV.parse(file, headers: true) do |row|
    invoice = Invoice.new({
      id: row[0],
      customer_id: row[1],
      status: row[2],
      created_at: row[3],
      updated_at: row[4]
      })
      invoice.save
      p "#{invoice.id} saved"
  end
  p "There are #{Invoice.count} records in the invoices table"

  file = File.read(Rails.root.join('db', 'data', 'merchants.csv'))

  CSV.parse(file, headers: true) do |row|
    merchant = Merchant.new({
      id: row[0],
      name: row[1],
      created_at: row[2],
      updated_at: row[3]
      })
      merchant.save
      p "#{merchant.name} saved"
  end
  p "There are #{Merchant.count} records in the merchants table"

  file = File.read(Rails.root.join('db', 'data', 'items.csv'))

  CSV.parse(file, headers: true) do |row|
    item = Item.new({
      id: row[0],
      name: row[1],
      description: row[2],
      unit_price: row[3],
      merchant_id: row[4],
      created_at: row[5],
      updated_at: row[6]
      })
      item.save
      p "#{item.name} saved"
  end
  p "There are #{Item.count} records in the items table"

  file = File.read(Rails.root.join('db', 'data', 'transactions.csv'))

  CSV.parse(file, headers: true) do |row|
    transaction = Transaction.new({
      id: row[0],
      invoice_id: row[1],
      credit_card_number: row[2],
      credit_card_expiration_date: row[3],
      result: row[4],
      created_at: row[5],
      updated_at: row[6]
      })
      transaction.save
      p "#{transaction.id} saved"
  end
  p "There are #{Transaction.count} records in the transactions table"

  file = File.read(Rails.root.join('db', 'data', 'invoice_items.csv'))

  CSV.parse(file, headers: true) do |row|
    invoice_item = InvoiceItem.new({
      id: row[0],
      item_id: row[1],
      invoice_id: row[2],
      quantity: row[3],
      unit_price: row[4],
      status: row[5],
      created_at: row[6],
      updated_at: row[7]
      })
    invoice_item.save
    p "#{invoice_item.id} saved"
  end
  p "There are #{InvoiceItem.count} records in the invoice_items table"
  end
end
