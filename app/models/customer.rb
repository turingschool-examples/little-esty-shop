class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  scope :with_successful_transactions, lambda {
                                         joins(invoices: :transactions)
                                           .where('transactions.result =?', 0)
                                       }

  def self.top_five_customers
    with_successful_transactions
      .select("customers.*, count('transactions') AS transaction_count")
      .group('customers.id')
      .order('transaction_count DESC')
      .limit(5)
  end
end
