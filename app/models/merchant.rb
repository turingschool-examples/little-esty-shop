class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  def top_five_customers
    Customer.joins(invoices: :items)
            .where('merchant_id = ?', self.id)
            .joins(invoices: :transactions)
            .where('result = ?', "success")
            .select("customers.*, count('transactions.result') as successful_transactions")
            .group('customers.id')
            .order(successful_transactions: :desc)
            .limit(5)
  end
end



