require 'csv'

namespace :csv_load do
  task customers: :environment do 
    csv = CSV.open './db/data/customers.csv', headers: true, header_converters: :symbol
    csv.each do |row|
      Customer.create!(first_name: row[:first_name], last_name: row[:last_name], created_at: row[:created_at], updated_at: row[:updated_at])
    end
  end

  task transactions: :environment do 
    
    csv = CSV.open './db/data/transactions.csv', headers: true, header_converters: :symbol
    
    csv.each do |row|
      row[:result] == 'success' ? result = 0 : result = 1
      Transaction.create!(
        invoice_id: row[:invoice_id], 
        credit_card_number: row[:credit_card_number], 
        cc_expiration: row[:cc_expiration], 
        result: result, 
        created_at: row[:created_at], 
        updated_at: row[:updated_at])
        
    end
  end
end
