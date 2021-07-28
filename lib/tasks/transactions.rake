require 'csv'

namespace :csv_load do
  desc "Load Transactions CSV"
  task transactions: :environment do
    Transaction.destroy_all
    # Invoice.destroy_all
    # Rake::Task["csv_load:invoices"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!(:transactions)
    csv_path = 'db/data/transactions.csv'
    csv = CSV.open(csv_path, headers: true)
    csv.each do |row|
      Transaction.create!(invoice_id: row['invoice_id'], credit_card_number: row['credit_card_number'], credit_card_expiration_date: row['credit_card_expiration_date'], result: row['result'])
    end
  end
end
