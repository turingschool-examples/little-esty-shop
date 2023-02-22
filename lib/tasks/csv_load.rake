require 'csv'
namespace :csv_load do
  
  task :customers do
    #environment
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      require 'pry'; binding.pry
      Customer.create!(row.to_h)
    end
  end

  task :invoice_items do
    CSV.read(invoice_items.csv)
  end

  task :invoices do
    CSV.read(invoices.csv)
  end

  task :items do
    CSV.read(items.csv)
  end

  task :merchants do
    CSV.read(merchants.csv)
  end

  task :transactions do
    CSV.read(transactions.csv)
  end
end