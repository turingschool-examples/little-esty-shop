namespace :load_csv do
  require 'csv'

  desc "create all"

  task :customers => :environment do
    CSV.foreach('db/data/customers.csv',:headers => true) do |row|
    Customer.create!({id: row[0],
                      first_name: row[1],
                      last_name: row[2],
                      created_at: row[3],
                      updated_at: row[4]
                      })
    end
  end

  task :merchants => :environment do
    CSV.foreach('db/data/merchants.csv',:headers => true) do |row|
      Merchant.create!({id: row[0],
                       name: row[1],
                       created_at: row[2],
                       updated_at: row[3]
                       })
    end 
  end


  task :items => :environment do
    CSV.foreach('db/data/items.csv',:headers => true) do |row|
      Item.create!({id: row[0], 
                    name: row[1], 
                    description: row[2], 
                    unit_price: row[3],   
                    merchant_id: row[4], 
                    created_at: row[5],
                    updated_at: row[6]
                    })
    end 
  end

  task :invoices => :environment do
    CSV.foreach('db/data/invoices.csv',:headers => true) do |row|
      if row.to_hash['status'] == "cancelled"
        status = 0
      elsif row.to_hash['status'] == "in progress"
        status = 1
      elsif row.to_hash['status'] == "completed"
        status = 2
      end 
      Invoice.create!({id: row[0], 
                        customer_id: row[1], 
                        merchant_id: row[2], 
                        status: status, 
                        created_at: row[4],
                        updated_at: row[5]})
    end 
  end 

  task :invoice_items => :environment do 
    CSV.foreach('db/data/invoice_items.csv',:headers => true) do |row|
      if row.to_hash['status'] == "pending"
        status = 0
      elsif row.to_hash['status'] == "packaged"
        status = 1 
      elsif row.to_hash['status'] == "shipped"
        status = 2
      end 
      InvoiceItem.create!({id: row[0], 
                            item_id: row[1], 
                            invoice_id: row[2], 
                            quantity: row[3], 
                            unit_price: row[4], 
                            status: status, 
                            created_at: row[6], 
                            updated_at: row[7]})
    end 
  end

  task :transactions => :environment do
    CSV.foreach('db/data/transactions.csv',:headers => true) do |row|
      if row.to_hash['result'] == "failed"
        result = 0
      elsif row.to_hash['result'] == "success"
        result = 1
      end
      Transaction.create!({id: row[0], 
                            invoice_id: row[1], 
                            credit_card_number: row[2], 
                            credit_card_expiration_date: row[3], 
                            result: result, 
                            created_at: row[5], 
                            updated_at: row[6]})
    end 
  end

  task :all => [:customers, :merchants, :invoices, :items, :invoice_items, :transactions]
end