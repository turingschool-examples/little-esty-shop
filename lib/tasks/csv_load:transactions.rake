require 'csv'
namespace :csv_load do
  desc "TODO"
  task transactions: :environment do

    csv_text = File.read(Rails.root.join("db","data","transactions.csv"))
  	csv = CSV.parse(csv_text, :headers => true)
  	csv.each do |row|
      t = Transaction.new
      t.invoice_id = row["invoice_id"]
      t.credit_card_number = row["credit_card_number"]
      t.credit_card_expiration_date = row["credit_card_expiration_date"]
      t.result = row["result"]
      t.created_at = row["created_at"]
      t.updated_at = row["updated_at"]
      t.save
    end
  end

end
