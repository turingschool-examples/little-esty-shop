require 'csv'


namespace :csv_load do
  desc 'importing customers from csv file'
    task customers: :environment do
      Customer.destroy_all
      CSV.foreach("db/data/customers.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Customer.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    end

  desc 'importing invoice items from csv file'
    task invoice_items: :environment do
      InvoiceItem.destroy_all
      CSV.foreach("db/data/invoice_items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        if row.to_hash[:status] == 'pending'
          status = 0
        elsif row.to_hash[:status] == 'packaged'
          status = 1
        elsif row.to_hash[:status] == 'shipped'
          status = 2
        end
        InvoiceItem.create!({ id:          row[0],
                              item_id:     row[1],
                              invoice_id:  row[2],
                              quantity:    row[3],
                              unit_price:  row[4],
                              status:      status,
                              created_at:  row[6],
                              updated_at:  row[7]
                            })
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    end

  desc 'importing invoices from csv file'
    task invoices: :environment do
      Invoice.destroy_all
      CSV.foreach("db/data/invoices.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        if row.to_hash[:status] == 'cancelled'
          status = 0
        elsif row.to_hash[:status] == 'in progress'
          status = 1
        elsif row.to_hash[:status] == 'completed'
          status = 2
        end
        Invoice.create!({ id:          row[0],
                          customer_id: row[1],
                          status:      status,
                          created_at:  row[4],
                          updated_at:  row[5]
                        })
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    end

  desc 'importing items from csv file'
    task items: :environment do
      Item.destroy_all
      CSV.foreach("db/data/items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Item.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('items')
    end

  desc 'importing merchants from csv file'
    task merchants: :environment do
      Merchant.destroy_all
      CSV.foreach("db/data/merchants.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Merchant.create!(row.to_hash)
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    end

  desc 'importing transactions from csv file'
    task transactions: :environment do
      Transaction.destroy_all
      CSV.foreach("db/data/transactions.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        if row.to_hash[:result] == 'failed'
          result = 0
        elsif row.to_hash[:result] == 'success'
          result = 1
        end
        Transaction.create!({ id:                          row[0],
                              invoice_id:                  row[1],
                              credit_card_number:          row[2],
                              credit_card_expiration_date: row[3],
                              result:                      result,
                              created_at:                  row[5],
                              updated_at:                  row[6]
                            })
      end
      ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    end

  desc 'importing all of the csv files'
    task all: :environment do
      Merchant.destroy_all
      Customer.destroy_all
      Invoice.destroy_all
      Item.destroy_all
      Transaction.destroy_all
      InvoiceItem.destroy_all

      CSV.foreach("db/data/merchants.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Merchant.create!(row.to_hash)
      end

      CSV.foreach("db/data/customers.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Customer.create!(row.to_hash)
      end

      CSV.foreach("db/data/invoices.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        if row.to_hash[:status] == 'cancelled'
          status = 0
        elsif row.to_hash[:status] == 'in progress'
          status = 1
        elsif row.to_hash[:status] == 'completed'
          status = 2
        end
        Invoice.create!({ id:          row[0],
                          customer_id: row[1],
                          status:      status,
                          created_at:  row[4],
                          updated_at:  row[5]
                        })
      end

      CSV.foreach("db/data/items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        Item.create!(row.to_hash)
      end

      CSV.foreach("db/data/transactions.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        if row.to_hash[:result] == 'failed'
          result = 0
        elsif row.to_hash[:result] == 'success'
          result = 1
        end
        Transaction.create!({ id:                          row[0],
                              invoice_id:                  row[1],
                              credit_card_number:          row[2],
                              credit_card_expiration_date: row[3],
                              result:                      result,
                              created_at:                  row[5],
                              updated_at:                  row[6]
                            })
      end

      CSV.foreach("db/data/invoice_items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
        if row.to_hash[:status] == 'pending'
          status = 0
        elsif row.to_hash[:status] == 'packaged'
          status = 1
        elsif row.to_hash[:status] == 'shipped'
          status = 2
        end
        InvoiceItem.create!({ id:          row[0],
                              item_id:     row[1],
                              invoice_id:  row[2],
                              quantity:    row[3],
                              unit_price:  row[4],
                              status:      status,
                              created_at:  row[6],
                              updated_at:  row[7]
                            })
      end

      ActiveRecord::Base.connection.reset_pk_sequence!('all')
  end
end
