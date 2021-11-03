class Customer < ApplicationRecord
  has_many :invoices
  attr_accessor :transaction_count

  def successful_transactions_count#(merchant_id)
    invoice_ids = self.invoices.pluck(:id)
    transaction_ids = Transaction.where(invoice_id: invoice_ids).where(result: 'success').count
  end
end

# find all customers related to merchant
# number of successful transactions for each customer (done)
# return top 5 customers with highest # of successful transactions
