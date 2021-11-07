class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices

  def successful_transactions_count
    invoice_ids = self.invoices.pluck(:id)
    transaction_ids = Transaction.where(invoice_id: invoice_ids).where(result: 'success').count
  end
end

# find all customers related to merchant
# number of successful transactions for each customer (done)
# return top 5 customers with highest # of successful transactions
