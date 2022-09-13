namespace: csv_load do
  desc 'customers'
  task :customers => :environment do
    
    Customer.create!({
      id:  row[0],
      first_name: row[1],
      last_name: row[2]
    })
  end

  desc 'invoice items'
  task :invoice_items => :environment do
    
    InvoiceItem.create!({
      id:  row[0],
      item_id: row[1],
      invoice_id: row[2],
      quantity: row[3],
      unit_price: row[4],
      status: row[5]
    })
  end

  desc 'invoices'
  task :invoices => :environment do
    
    Invoice.create!({
      id:  row[0],
      customer_id: row[1],
      status: row[2]
    })
  end

  desc 'items'
  task :items => :environment do
    
    Item.create!({
      id:  row[0],
      name: row[1],
      description: row[2],
      unit_price: row[3],
      merchant_id: row[4]
    })
  end

  desc 'merchants'
  task :merchants => :environment do
    
    Merchant.create!({
      id:  row[0],
      name: row[1]
    })
  end

  desc 'transactions'
  task :transactions => :environment do
    
    Transaction.create!({
      id:  row[0],
      invoice_id: row[1],
      credit_card_number: row[2],
      credit_card_expiration_date: row[3],
      result: row[4]
    })
  end

  desc "csv load all"
  task :all => [:customers, :invoice_items, :invoices, :items, :merchants, :transactions]
end