require 'csv'

namespace :csv_load do
  desc 'This task loads data for the transactions'
  task transactions: [:environment] do
    file = Rails.root.join('db', 'data', 'transactions.csv')
    csv_text = File.read(file)
    csv = CSV.parse(csv_text.scrub, headers: true)
    csv.each do |row|
      t = Transaction.new
      t.id = row['id']
      t.invoice_id = row['invoice_id']
      t.credit_card_number = row['credit_card_number']
      t.cc_expiration_date = row['credit_card_expiration_date']
      # require "pry"; binding.pry
      if row['result'] == 'success'
        t.result = 1
      elsif row['result'] == 'failed'
        t.result = 0
      end
      # t.result = row['result']
      t.created_at = row['created_at']
      t.updated_at = row['updated_at']
      t.save!
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end
end